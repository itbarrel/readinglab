# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  concern :trashable do
    collection do
      delete :trash
    end
  end

  devise_for :users, controllers: { registrations: :registrations }

  mount Sidekiq::Web => '/sidekiq'

  resources :accounts, :rooms, :teachers, :vacations, :staffs, :books, :forms, concerns: :trashable
  resources :message_templates, :form_fields, :field_values, :trajectory_details, concerns: :trashable
  resources :receipt_types, :receipts, concerns: :trashable

  resources :events, only: %i[show update]
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
      get :attendance, action: 'open_attendance'
      post :attendance, action: 'submit_attendance'
      get :form, action: 'open_form'
      post :form, action: 'submit_form'
    end
  end

  resources :interviews do
    member do
      get :form, action: 'open_form'
      post :form, action: 'submit_form'
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
