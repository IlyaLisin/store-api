# frozen_string_literal: true

Rails.application.routes.draw do
  scope :v1 do
    devise_for :users, only: []
  end

  namespace :v1 do
    namespace :accounts do
      post '/session', to: 'sessions#create_session'
      post '/sign_up', to: 'registrations#create'
      patch '/email_confirmation', to: 'registrations#confirm_email'
      delete '/session', to: 'sessions#destroy'
      get '/', to: 'users#show'
    end

    resources :products, only: :index
    resources :purchase_orders, only: :create
  end
end
