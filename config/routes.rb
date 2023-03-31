# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  resources :accounts, :vacations, :rooms, :interviews, :teachers, :staffs, :books
  resources :message_templates, :form_fields, :field_values, :trajectory_details

  resources :parents, :forms, :receipt_types, :receipts

  resources :events, only: %i[show]
  resources :student_classes, only: %i[create destroy]
  resources :klass_templates do
    member do
      get :assign
    end
  end

  resources :klasses do
    collection do
      get :availability
    end
    member do
      post :extend_sessions
    end
  end

  resources :meetings do
    member do
      get :open_attendance_form
    end
  end

  resources :students do
    collection do
      get :present_search
    end
  end

  resources :reports, only: %i[] do
    collection do
      get :graph
    end
  end

  scope module: :pages do
    get :home
    get :calendar
    get :communication
    get :profile
  end

  post :notify, controller: :emails, action: :notify

  root 'pages#home'
end
