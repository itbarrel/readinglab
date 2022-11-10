# frozen_string_literal: true

require 'sidekiq/web' 
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  resources :accounts 
  resources :vacations 


  # Defines the root path route ("/")
  root 'pages#home'
end
