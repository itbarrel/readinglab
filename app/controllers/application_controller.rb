# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ApplicationHelper
  # include EsbuildErrorRendering if Rails.env.development?

  before_action :generate_sidebar, unless: :json_request?
  before_action :authenticate_user!

  layout :set_layout
  helper_method :zone_date, :bootstrap_class_for

  def generate_sidebar
    @menu_list = {
      'General': [
        { url: '/calendar', text: 'Calendar', class: '', icon: 'fas fa-calendar-alt', sub_items: [] },
        { text: 'Registration', class: '', icon: 'fab fa-trello', sub_items: [
          { url: '/parents', text: 'Parents', class: '', icon: 'micon bi bi-people' },
          { url: '/students', text: 'Student Listing', class: '', icon: 'micon bi bi-layout-text-sidebar-reverse' },
          { url: '/interviews', text: 'Interviews', class: '', icon: 'micon bi bi-input-cursor' }

        ] },
        { text: 'Classes', class: '', icon: 'micon bi bi-basket', sub_items: [
          { url: '/klasses', text: 'Active', class: '', icon: 'micon bi bi-book' },
          { url: '/rooms', text: 'Obselote', class: '', icon: 'micon fa fa-bank' }

        ] },
        { url: '/communication', text: 'Communication', class: '', icon: 'micon bi bi-calendar4-week', sub_items: [] }
      ],
      'Settings': [
        { url: '/klass_templates', text: 'Class tempelate ', class: '', icon: 'micon bi bi-book' },
        { url: '/rooms', text: 'Rooms', class: '', icon: 'micon bi bi-bank' },
        { url: '/staffs', text: 'Staff', class: '', icon: 'micon bi bi-people' },
        { url: '/vacations', text: 'Vacations', class: '', icon: 'micon fa fa-plane' },
        { url: '/profile', text: 'Profile', class: '', icon: 'micon bi bi-person' }
      ]
    }
  end

  def set_layout
    if user_signed_in?
      'application'
    else
      'welcome'
    end
  end

  private

  def json_request?
    request.format.symbol == :json
  end

  def js_request?
    request.format.symbol == :js
  end

  def attach_account_for(resource)
    resource.account = current_user.account
  end

  def current_account
    current_user.account
  end

  def zone_date(date)
    timezone = current_account.timezone || 'Asia/Karachi'
    date.in_time_zone(timezone)
  end

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :success || :notice
      'bg-success'
    when :error || :alert
      'bg-warning'
    else
      flash_type.to_s
    end
  end
end
