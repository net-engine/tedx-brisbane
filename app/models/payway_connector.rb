require 'activemerchant'

class PaywayConnector
  def self.make_payment!(attendee, transaction_params)
    pc       = PaywayConnector.new(attendee, transaction_params)
    response = pc.pay!
    pc.register_payment(response)
  end

  attr_reader :attendee, :amount, :cc_details, :options

  def initialize(attendee, params)
    @attendee   = check_and_return_attendee(attendee)
    @amount     = check_and_return_amount(params)
    @cc_details = check_and_return_cc_details(params)
    @options    = {
      order_number: attendee.id
    }
  end

  def pay!
    amount_in_cents = @amount * 100
    response       = gateway.purchase(amount_in_cents, cc, @options)
    response_title = response.message.split(' - ', 2).first rescue ""
    raise Exceptions::DeclinedTransaction.new(msg_params: { third_party_response: response_title}) unless response_title == 'Approved'
    return response
  end

  def register_payment(response)
    if @attendee.payments.create! amount: amount,
                                  receipt_number: response.params['receipt_no'],
                                  masked_number: @cc_details[:number].last(4),
                                  card_type: @cc_details[:brand]
      attendee.pay!
      attendee.update_student_attribute(amount)
      attendee.emails.create(event: 'pay').deliver
    end
  end

  private

  def check_and_return_attendee(attendee)
    raise Exceptions::InvalidAttendee unless attendee && attendee.received_invitation?
    return attendee
  end

  def check_and_return_amount(params)
    params[:student_amount] == "true" ? Event.price_in_dollars_for_student : Event.price_in_dollars
  end

  def check_and_return_cc_details(params)
    first_name = params[:transaction][:customer][:first_name] rescue nil
    last_name  = params[:transaction][:customer][:last_name] rescue nil
    number     = params[:transaction][:credit_card][:number] rescue nil
    month      = params[:transaction][:credit_card][:expiration_date].split('/', 2).first.to_i rescue nil
    year       = "20" + params[:transaction][:credit_card][:expiration_date].split('/', 2).last rescue nil
    cvv        = params[:transaction][:credit_card][:cvv] rescue nil
    brand      = params[:transaction][:credit_card][:type] rescue nil

    raise Exceptions::MissingCCField unless first_name && last_name && number && month && year && cvv && brand
    raise Exceptions::UnsupportedCCBrand unless ['visa', 'master'].include? brand

    return {
      number:              number,
      month:               month,
      year:                year,
      first_name:          first_name,
      last_name:           last_name,
      verification_value:  cvv,
      brand:               brand
    }
  end

  def gateway
    @gateway ||= ::ActiveMerchant::Billing::PayWayGateway.new(
      username: PAYWAY.username,
      password: PAYWAY.password,
      merchant: PAYWAY.merchant,
      pem:      PAYWAY.pem_file
    )
  end

  def cc
    @cc ||= ::ActiveMerchant::Billing::CreditCard.new(@cc_details)
  end

end
