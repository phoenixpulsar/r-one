Rails.application.routes.draw do
  root "storefront#index"

  resources :products, only: %i[index show]
  resource :cart, only: :show
  resource :checkout, only: :show

  namespace :integrations do
    resource :stripe_checkout, only: :create, controller: "stripe_checkouts"
  end

  post "stripe/webhooks", to: "stripe_webhooks#create"

  namespace :printful do
    resources :products, only: %i[index create]
    post "webhooks", to: "webhooks#create"
  end

  get "signup", to: "registrations#new"
  post "signup", to: "registrations#create"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "up" => "rails/health#show", as: :rails_health_check
end
