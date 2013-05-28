require 'sidekiq/web'

TedxBrisbane::Application.routes.draw do
  root :to => "pages#index"

  get '/confirm/:confirm_token', to: "email_links#confirm"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/sidekiq' if Rails.env == "development"
end
