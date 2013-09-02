MANDRILL = OpenStruct.new(
  key: ENV['TEDX_MANDRILL_API_KEY']
)

TICKET = OpenStruct.new(
  price_in_dollars: 95,
  price_in_dollars_for_student: 50
)


PAYWAY = OpenStruct.new(
  username: ENV['TEDX_PAYWAY_USERNAME'],
  password: ENV['TEDX_PAYWAY_PASSWORD'],
  merchant: ENV['TEDX_PAYWAY_MERCHANT'],
  pem_file: ENV['TEDX_PAYWAY_PEM_FILE']
)
