MANDRILL = OpenStruct.new(
  key: ENV['TEDX_MANDRILL_API_KEY']
)

TICKET = OpenStruct.new(
  price_in_dollars: 95,
  price_in_dollars_for_student: 50
)

PAYWAY = OpenStruct.new(
  YAML.load_file("#{Rails.root}/config/payway.yml")
)
