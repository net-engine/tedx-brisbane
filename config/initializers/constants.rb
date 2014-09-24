MANDRILL = OpenStruct.new(
  key: ENV['TEDX_MANDRILL_API_KEY']
)

Event = OpenStruct.new(
  price_in_dollars:            135,
  price_in_dollars_for_student: 85,
  date:                    Date.parse("5 October 2014"),
  doors_open_at:                "8.55am",
  starts_at:                    "9am",
  ends_at:                      "9.30pm",
  drink_time_range:             "5:30 to 9:00 pm",
  location:                     "Brisbane Powerhouse",
  address:                      "119 Lamington St, New Farm QLD 4005",
  header_title:                 "5 &middot; 10 &middot; 14 @ Powerhouse",
  registration_open_and_close_time: "open at 7.45am and close at 8.45am"
)

# See HOSTNAME in application.rb

PAYWAY = OpenStruct.new(
  YAML.load_file("#{Rails.root}/config/payway.yml")
)
