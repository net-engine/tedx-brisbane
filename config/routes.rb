require "sidekiq/web"

TedxBrisbane::Application.routes.draw do
  root :to => "pages#index"

  get "/confirm/:token", to: "email_links#confirm"
  get "/decline/:token", to: "email_links#decline"
  get "/pay/:token", to: "email_links#pay"
  get "/payment/:token", to: "payments#new", as: "new_payment"
  get "/payments/confirm" => "payments#confirm", as: "confirm_payment"
  get "/api/v1/attendees/statistics" => "api/v1/attendees#statistics", as: "statistics_api_v1_attendees"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => "/sidekiq" if Rails.env == "development"
end
