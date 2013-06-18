require 'simplecov'
SimpleCov.start

require 'coveralls'
Coveralls.wear!

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/poltergeist'
require 'sidekiq/testing'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.before(:each) do
    if example.metadata[:js] == true
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end

    unless example.metadata[:enable_observer] == true
      AttendeeObserver.any_instance.stub(:after_create)
      AttendeeObserver.any_instance.stub(:after_save)
      AttendeeObserver.any_instance.stub(:after_destroy)
    end

    DatabaseCleaner.start

    EmailDeliveryWorker.jobs.clear
    InvitationRevokerWorker.jobs.clear
    RealtimeStatisticsWorker.jobs.clear
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  Capybara.register_driver :poltergeist_debug do |app|
    Capybara::Poltergeist::Driver.new(app, inspector: true, js_errors: true, timeout: 300)
  end

  HandlebarsAssets::Config.path_prefix = 'spec/javascript/templates'

  BCrypt::Engine::DEFAULT_COST = 1
  Capybara.javascript_driver = :poltergeist_debug
end
