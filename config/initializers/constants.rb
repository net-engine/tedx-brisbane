MANDRILL = OpenStruct.new(
  key: ENV['TEDX_MANDRILL_API_KEY']
)

Event = OpenStruct.new(
  price_in_dollars:            135,
  price_in_dollars_for_student: 85,
  date:                         Date.parse("5 October 2014")
)

PAYWAY = OpenStruct.new(
  YAML.load_file("#{Rails.root}/config/payway.yml")
)
