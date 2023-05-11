# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ApplicationHelper
  # include EsbuildErrorRendering if Rails.env.development?

  before_action :generate_sidebar, unless: :json_request?
  around_action :set_time_zone, if: :current_user
  before_action :authenticate_user!

  layout :set_layout
  helper_method :zone_date, :bootstrap_class_for, :status_for_interview, :interview_status_icon, :current_account

  def generate_sidebar
    settings = [
      { url: '/accounts', text: 'Account', class: '', icon: 'bi bi-people-fill', sub_items: [], model: Account },
      { url: '/klass_templates', text: 'Class Templates ', class: '', icon: 'micon bi bi-people-fill', model: KlassTemplate },
      { url: '/forms', text: 'Forms', class: '', icon: 'micon bi bi-clipboard-data-fill', model: Form },
      { url: '/message_templates', text: 'Message Templates', class: '', icon: 'bi bi-envelope-fill', model: MessageTemplate },
      { url: '/payments', text: 'Payments', class: '', icon: 'micon bi bi-credit-card', model: Payment },
      { url: '/rooms', text: 'Rooms', class: '', icon: 'micon bi bi-building-fill', model: Room },
      { url: '/receipt_types', text: 'Receipt Types', class: '', icon: 'micon bi bi-receipt-cutoff', model: ReceiptType },
      { url: '/staffs', text: 'Staff', class: '', icon: 'micon bi bi-person-vcard', model: User },
      { url: '/vacations', text: 'Vacations', class: '', icon: 'micon bi bi-train-front-fill', model: Vacation }
    ]
    @menu_list = {
      'General': [
        { url: '/calendar', text: 'Calendar', class: '', icon: 'bi bi-calendar', sub_items: [] },
        { text: 'Registration', class: '', icon: 'bi bi-person-plus-fill', sub_items: [
          { url: '/parents', text: 'Parents', class: '', icon: 'micon bi bi-people' },
          { url: '/students', text: 'Student Listing', class: '', icon: 'micon bi bi-layout-text-sidebar-reverse' },
          { url: '/interviews', text: 'Interviews', class: '', icon: 'micon bi bi-calendar-week' }
        ] },
        { text: 'Classes', class: '', icon: 'micon bi bi-book-half', sub_items: [
          { url: '/klasses', text: 'Active', class: '', icon: 'micon bi bi-check-circle' }
          # { url: '/rooms', text: 'Obselote', class: '', icon: 'micon bi bi-exclamation-circle' }
        ] },
        { text: 'Billing', class: '', icon: 'micon bi bi-file-earmark-text-fill', sub_items: [
          { url: '/receipts', text: 'Receipts', class: '', icon: 'micon bi bi-receipt', sub_items: [] }
        ] },
        { url: '/communication', text: 'Communication', class: '', icon: 'micon bi bi-chat-text-fill', sub_items: [] },
        { text: 'Reports', class: '', icon: 'micon bi bi-bar-chart-line-fill', sub_items: [
          { url: '/reports/graph', text: 'Graph Report', class: '', icon: 'micon bi bi-graph-up-arrow' }
        ] }
      ],
      'Settings': []
    }

    settings.each do |setting|
      @menu_list[:Settings].push(setting) if can? :read, setting[:model]
    end
    @menu_list[:Settings].push({ url: '/profile', text: 'Profile', class: '', icon: 'micon bi bi-person-circle' })
  end

  def set_layout
    if user_signed_in?
      'application'
    else
      'welcome'
    end
  end

  def export
    model_name = params[:controller].singularize.classify
    model = model_name.constantize
    respond_to do |format|
      format.csv { send_data model.to_csv, filename: "#{Time.zone.today.to_s.title}.csv" }
    end
  end

  private

  def set_time_zone(&block)
    Time.use_zone(current_account.timezone, &block)
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  protected

  def process_errors(resource, label = :error)
    resource.errors.full_messages.each do |msg|
      flash_message(label, msg)
    end
  end

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
    resource.account ||= current_user.account
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
