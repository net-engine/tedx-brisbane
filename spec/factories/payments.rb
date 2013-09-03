# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    attendee_id 1
    amount "9.99"
    receipt_number "MyString"
    masked_number "MyString"
    card_type "MyString"
  end
end
