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
  resources :message_templates, :trajectory_details, :grades, concerns: %i[trashable exportable]
  resources :receipt_types, :receipts, :notices, :parents, :payments, concerns: %i[trashable exportable]

  resources :events, only: %i[show update]
  resources :student_classes, only: %i[create destroy]

  resources :staffs do
    concerns %i[trashable exportable]
    member do
      get :password
      put :mark_active
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
      get  :obsolete
    end
    member do
      get  :details
      put  :mark_obsolete
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

  resources :form_details, only: %i[] do
    concerns %i[exportable]
  end

  resources :students do
    concerns %i[trashable exportable]
    collection do
      get :present_search
    end

    member do
      get :interviews
      get :reset_billing
      get :student_attendance
      get :student_attendance_search
    end
  end

  resources :reports, only: %i[] do
    collection do
      get :weekly_attendance
      get :weekly_receipts
      get :students
      get :graph
      get '/graph/:id', action: 'student_graph', as: 'student_graph'
      get :books
      get :grades
      get :daily
      get :student
    end
  end

  resources :billings, only: %i[edit] do
    collection do
      get :students
    end
  end

  resources :notifications, only: %i[] do
    member do
      post :read
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
