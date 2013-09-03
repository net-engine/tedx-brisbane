require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

HOSTNAME = OpenStruct.new(
  development: 'http://127.0.0.1:3000',
  staging: 'http://tedx.netengine.com.au',
  production: 'https://register.tedxbrisbane.com'
)

module TedxBrisbane
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.active_record.observers = :attendee_observer
    config.asset_host = HOSTNAME.public_send(Rails.env)
  end
end
