# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  concern :trashable do
    collection do
      delete :trash
    end
  end

  concern :exportable do
    collection do
      get :export
    end
  end

  devise_for :users, controllers: { registrations: :registrations }

  mount Sidekiq::Web => '/sidekiq'

  resources :rooms, :teachers, :vacations, :books, concerns: %i[trashable exportable]
  resources :message_templates, :trajectory_details, concerns: %i[trashable exportable]
  resources :receipt_types, :receipts, :parents, :payments, concerns: %i[trashable exportable]

  resources :events, only: %i[show update]
  resources :student_classes, only: %i[create destroy]

  resources :staffs do
    concerns %i[trashable exportable]
    member do
      put :passwords
    end
  end

  resources :forms do
    concerns %i[trashable exportable]
    member do
      post :form_duplicate
    end
  end

  resources :accounts do
    concerns %i[trashable exportable]
    member do
      get :stats
    end
  end

  resources :klass_templates do
    concerns %i[trashable exportable]
    member do
      get :assign
    end
  end

  resources :klasses do
    concerns %i[trashable exportable]
    collection do
      get :availability
      get  :obselete
    end
    member do
      post :extend_sessions
    end
  end

  resources :meetings do
    concerns %i[trashable exportable]
    member do
      get :form_details
      get :student_details

      get :attendance, action: 'open_attendance'
      post :attendance, action: 'submit_attendance'
      get :form, action: 'open_form'
      post :form, action: 'submit_form'
      put :form, action: 'save_form'
      get :forms
      get :student_detail, action: 'open_student_details'
    end
  end

  resources :interviews do
    concerns %i[trashable exportable]
    member do
      get :form, action: 'open_form'
      post :form, action: 'submit_form'
      get :form_details
    end
  end

  resources :students do
    concerns %i[trashable exportable]
    collection do
      get :present_search
    end

    member do
      get :interviews
    end
  end

  resources :reports, only: %i[] do
    collection do
      get :weekly_attendance
      get :graph
      get :daily
    end
  end

  resources :billings, only: %i[] do
    collection do
      get :students
    end
  end

  scope module: :pages do
    get :home
    get :calendar
    get :communication
    get :profile
    get :health
  end

  post :notify, controller: :emails, action: :notify

  root 'pages#home'
end
