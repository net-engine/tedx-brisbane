source 'https://rubygems.org'

gem 'rails', '4.0.0'

gem 'rails-observers'
gem 'active_model_serializers'
gem 'bcrypt-ruby'
gem 'braintree'
gem 'coffee-rails'
gem 'haml-rails'
gem 'handlebars_assets'
gem 'httparty'
gem 'pg'
gem 'pusher'
gem 'sass-rails'
gem 'sidekiq'
gem 'state_machine'
gem 'turbolinks'
gem 'uglifier'
gem 'compass-rails', github: 'milgner/compass-rails', branch: 'rails4'
gem 'formtastic', github: 'justinfrench/formtastic', branch: 'rails4beta'
gem 'responders', github: 'plataformatec/responders'
gem 'inherited_resources', github: 'josevalim/inherited_resources'
gem 'ransack', github: 'ernie/ransack', branch: 'rails-4'
gem 'activeadmin', github: 'akashkamboj/active_admin', branch: 'rails4'

group :staging, :production do
  gem 'unicorn'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'slim', ">= 1.3.0"
  gem 'sinatra', '>= 1.3.0', :require => nil
end

group :development, :test do
  gem 'awesome_print'
  gem 'coveralls', require: false
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'pry'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rspec-rails'
  gem 'konacha'
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
