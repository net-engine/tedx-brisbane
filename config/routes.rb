require "sidekiq/web"

TedxBrisbane::Application.routes.draw do
  root :to => "pages#index"

  get "/confirm/:token", to: "email_links#confirm"
  get "/decline/:token", to: "email_links#decline"
  get "/pay/:token", to: "email_links#pay"
  get "/payment/:token", to: "payments#new", as: "new_payment"
  get "/payments/confirm" => "payments#confirm", as: "confirm_payment"

  namespace :api do
    namespace :v1 do
      resources :attendees, only: [:create] do
        collection do
          get 'statistics'
        end
      end
    end
  end


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => "/sidekiq" if Rails.env == "development"
end
