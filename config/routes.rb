# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  resources :accounts, :vacations, :rooms, :interviews, :teachers, :staffs
  resources :klass_templates, :parents, :klasses, :meetings
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
