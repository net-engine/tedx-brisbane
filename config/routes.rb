require 'sidekiq/web'

TedxBrisbane::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env == "development"
end
