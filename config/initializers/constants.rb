MANDRILL = OpenStruct.new(
  key: ENV['TEDX_MANDRILL_API_KEY']
)

TICKET = OpenStruct.new(
  price_in_dollars: 100
)

HOSTNAME = OpenStruct.new(
  test: 'www.example.com',
  development: '127.0.0.1:3000',
  staging: 'tedx.netengine.com.au',
  production: 'tedxbrisbane.com'
)
