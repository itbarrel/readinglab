# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ApplicationHelper
  # include EsbuildErrorRendering if Rails.env.development?

  before_action :generate_sidebar, unless: :json_request?
  before_action :authenticate_user!

  layout :set_layout
  helper_method :zone_date, :bootstrap_class_for, :status_for_interview, :interview_status_icon, :current_account

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
        { text: 'Billing', class: '', icon: 'micon bi bi-basket', sub_items: [
          { url: '/receipts', text: 'Receipts', class: '', icon: 'micon bi bi-calendar4-week', sub_items: [] }

        ] },
        { url: '/communication', text: 'Communication', class: '', icon: 'micon bi bi-calendar4-week', sub_items: [] }

      ],
      'Settings': [
        { url: '/klass_templates', text: 'Class tempelate ', class: '', icon: 'micon bi bi-book' },
        { url: '/rooms', text: 'Rooms', class: '', icon: 'micon bi bi-bank' },
        { url: '/staffs', text: 'Staff', class: '', icon: 'micon bi bi-people' },
        { url: '/vacations', text: 'Vacations', class: '', icon: 'micon fa fa-plane' },
        { url: '/receipt_types', text: 'Receipt Types', class: '', icon: 'micon fa fa-plane' },
        { url: '/message_templates', text: 'Message Templates', class: '', icon: 'far fa-envelope' },
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

  def status_for_interview(status_type)
    case status_type.to_sym
    when :done
      'success'
    when :waiting
      'secondary'
    when :cancel
      'warning'
    else
      status_type.to_s
    end
  end

  def interview_status_icon(status_type)
    case status_type.to_sym
    when :done
      'fa-check'
    when :waiting
      'fa-stream'
    when :cancel
      'fa-ban'
    else
      status_type.to_s
    end
  end
end
