class PaymentFormHandler
  constructor : (@$form) ->
    @$submit = @$form.find '.submit-container'


  bindSubmitAction : ->
    @$submit.off 'click'
    @$submit.on 'click', (e) =>
      @$submit.spin('small', 'white')
      @$submit.find('.btn').val('')


  validate: ->
    @$form.validate({
      onkeyup: (element) -> $(element).valid(),
      rules: {
        "transaction[customer][first_name]": "required",
        "transaction[customer][last_name]": "required",
        "transaction[credit_card][type]": "required",
        "transaction[credit_card][number]": "required",
        "transaction[credit_card][expiration_date]": "required",
        "transaction[credit_card][cvv]": "required"
      },
      messages: {
        "transaction[customer][first_name]": "Please enter the first name as it appears in your credit card",
        "transaction[customer][last_name]": "Please enter the last name as it appears in your credit card",
        "transaction[credit_card][type]": "Please select your credit card brand",
        "transaction[credit_card][number]": "Please fill in your credit card number",
        "transaction[credit_card][expiration_date]": "Please fill in your credit card expiration date",
        "transaction[credit_card][cvv]": "Please fill in your credit card security code",
      },
      invalidHandler: (form, validator) =>
        @$submit.spin(false)
        @$submit.find('.btn').val('Submit')
    })


$ ->
  if $('#new_payment').length
    pfh = new PaymentFormHandler($('#new_payment'))
    pfh.bindSubmitAction()
    pfh.validate()



