require 'sidekiq/web'

TedxBrisbane::Application.routes.draw do
  root :to => 'pages#index'
  resources :payments

  get '/confirm/:token', to: "email_links#confirm"
  get '/decline/:token', to: "email_links#decline"
  get '/pay/:token', to: "email_links#pay"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/sidekiq' if Rails.env == "development"
end
