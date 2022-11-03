# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :student_forms
  resources :klass_forms
  resources :klass_tempelate_forms
  resources :parents
  resources :cities
  resources :student_meetings
  resources :form_details
  resources :interviews
  resources :student_classes
  resources :students
  resources :trajectory_details
  resources :receipt_types
  resources :receipts
  resources :meetingstudents
  resources :meetings
  resources :forms
  resources :content_libraries
  resources :books
  resources :klass_templates
  resources :rclasses
  resources :klasses
  resources :vacations
  resources :vacation_types
  resources :rooms
  devise_for :users
  resources :users, :only => [:index]
  resources :accounts
  resources :account_types

  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # root : "home#index"

end
