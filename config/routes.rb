require 'sidekiq/web'

TedxBrisbane::Application.routes.draw do
  root :to => "pages#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/sidekiq' if Rails.env == "development"
end
