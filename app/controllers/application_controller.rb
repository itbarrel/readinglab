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
        { url: '/calendar', text: 'Calendar', class: '', icon: 'bi bi-calendar-week-fill', sub_items: [] },
        { text: 'Registration', class: '', icon: 'bi bi-person-plus-fill', sub_items: [
          { url: '/parents', text: 'Parents', class: '', icon: 'micon bi bi-people' },
          { url: '/students', text: 'Student Listing', class: '', icon: 'micon bi bi-layout-text-sidebar-reverse' },
          { url: '/interviews', text: 'Interviews', class: '', icon: 'micon bi bi-calendar-week' }
        ] },
        { text: 'Classes', class: '', icon: 'micon bi bi-building-fill', sub_items: [
          { url: '/klasses', text: 'Active', class: '', icon: 'micon bi bi-check-circle' },
          { url: '/rooms', text: 'Obselote', class: '', icon: 'micon bi bi-exclamation-circle' }
        ] },
        { text: 'Billing', class: '', icon: 'micon bi bi-file-text-fill', sub_items: [
          { url: '/receipts', text: 'Receipts', class: '', icon: 'micon bi bi-receipt', sub_items: [] }
        ] },
        { url: '/communication', text: 'Communication', class: '', icon: 'micon bi bi-chat-text-fill', sub_items: [] },
        { text: 'Reports', class: '', icon: 'micon bi bi-bar-chart-line-fill', sub_items: [
          { url: '/reports/graph', text: 'Graph Report', class: '', icon: 'micon bi bi-graph-up-arrow' }
        ] }
      ],
      'Settings': [
        { url: '/klass_templates', text: 'Class Templates ', class: '', icon: 'micon bi bi-people-fill' },
        { url: '/rooms', text: 'Rooms', class: '', icon: 'micon bi bi-building-fill' },
        { url: '/staffs', text: 'Staff', class: '', icon: 'micon bi bi-person-vcard' },
        { url: '/vacations', text: 'Vacations', class: '', icon: 'micon bi bi-train-front-fill' },
        { url: '/receipt_types', text: 'Receipt Types', class: '', icon: 'micon bi bi-receipt-cutoff' },
        { url: '/message_templates', text: 'Message Templates', class: '', icon: 'bi bi-envelope-fill' },
        { url: '/profile', text: 'Profile', class: '', icon: 'micon bi bi-person-fill' }
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

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  protected

  def flash_message(type, text)
    flash[type] ||= []
    flash[type] << text
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
