# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendee do
    email_address { Faker::Internet.email }
    first_name "Dan"
    last_name  "Sowter"
    gender "M"
    age 32
    profession "Architect"
    tweet_idea "Heal the world. Make it a better place."
    scholarship false
  end
end
