# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  resources :accounts, :vacations, :rooms, :interviews, :teachers, :staffs
  resources :parents, :meetings, :forms, :receipt_types, :receipts

  resources :klass_templates do
    member do
      get :assign
    end
  end
  resources :klasses do
    collection do
      get :availability
    end
  end
  resources :students do
    collection do
      get :present_search
    end
  end
  scope module: :pages do
    get :home
    get :calendar
    get :communication
  end

  # Defines the root path route ("/")
  root 'pages#home'
end
