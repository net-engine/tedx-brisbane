source 'http://rubygems.org'

gem 'rails', '4.0.0'

gem 'rails-observers'
gem 'active_model_serializers'
gem 'bcrypt-ruby'
gem 'braintree'
gem 'coffee-rails'
gem 'haml-rails'
gem 'handlebars_assets'
gem 'httparty'
gem 'naught'
gem 'pg'
gem 'pusher'
gem 'sass-rails'
gem 'sidekiq'
gem 'state_machine'
gem 'turbolinks'
gem 'uglifier'
gem 'devise'
gem 'compass-rails'
gem 'formtastic'
gem 'responders'
gem 'inherited_resources'
gem 'ransack', github: 'ernie/ransack'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'jbuilder', '1.0.2'
gem 'rdoc', '3.12.2'
gem 'sdoc', '0.3.20'
gem 'sprockets', '2.11.0' # the activeadmin required devise tried to install v2.12.0 but which was expecting different apis
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'slim', ">= 1.3.0"
gem 'sinatra', '>= 1.3.0', :require => nil
gem "jquery-rails", "2.3.0"
gem 'activemerchant-payway'
gem 'addressable'
gem 'launchy'

group :staging, :production do
  gem 'unicorn'
end

group :development do
  gem 'capistrano', '< 3'
  gem "capistrano-sidekiq"
  gem 'capistrano-ext'
end

group :development, :test do
  gem 'awesome_print'
  gem 'coveralls', require: false
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'pry-meta'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rspec', '< 3' # we're using the old syntax
  gem 'rspec-rails'
  gem 'konacha'
  gem 'thin'
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
