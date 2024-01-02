# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ApplicationHelper
  # include EsbuildErrorRendering if Rails.env.development?

  before_action :generate_sidebar, unless: :js_request?
  before_action :fetch_notifications
  around_action :set_time_zone, if: :current_user
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  layout :set_layout
  helper_method :zone_date, :bootstrap_class_for, :status_for_interview, :interview_status_icon, :current_account

  def generate_sidebar
    settings = [
      { url: '/accounts', text: 'Account', class: '', icon: 'bi bi-people-fill', sub_items: [], model: Account },
      { url: '/klass_templates', text: 'Class Templates ', class: '', icon: 'micon bi bi-people-fill', model: KlassTemplate },
      { url: '/forms', text: 'Forms', class: '', icon: 'micon bi bi-clipboard-data-fill', model: Form },
      { url: '/message_templates', text: 'Message Templates', class: '', icon: 'bi bi-envelope-fill', model: MessageTemplate },
      { url: '/rooms', text: 'Rooms', class: '', icon: 'micon bi bi-building-fill', model: Room },
      { url: '/receipt_types', text: 'Receipt Types', class: '', icon: 'micon bi bi-receipt-cutoff', model: ReceiptType },
      { url: '/staffs', text: 'Staff', class: '', icon: 'micon bi bi-person-vcard', model: User },
      { url: '/vacations', text: 'Vacations', class: '', icon: 'micon bi bi-train-front-fill', model: Vacation },
      { url: '/approved_vacations', text: 'Approved Vacations', class: '', icon: 'bi bi-check-circle-fill', model: ApprovedVacation }
    ]
    general_items = [
      { url: '/calendar', text: 'Calendar', class: '', icon: 'bi bi-calendar', models: [Klass, Interview], sub_items: [] },
      { text: 'Registration', class: '', icon: 'bi bi-person-plus-fill', sub_items: [
        { url: '/parents', text: 'Parents', class: '', icon: 'micon bi bi-people', models: [Parent] },
        { url: '/students', text: 'Student Listing', class: '', icon: 'micon bi bi-layout-text-sidebar-reverse', models: [Student] },
        { url: '/interviews', text: 'Interviews', class: '', icon: 'micon bi bi-calendar-week', models: [Interview] }
      ] },
      { text: 'Classes', class: '', icon: 'micon bi bi-book-half', sub_items: [
        { url: '/klasses', text: 'Active', class: '', icon: 'micon bi bi-check-circle', models: [Klass] },
        { url: '/klasses/obsolete', text: 'Obsolote', class: '', icon: 'micon bi bi-exclamation-circle', models: [Klass] }
      ] },
      { text: 'Billing', class: '', icon: 'micon bi bi-file-earmark-text-fill', sub_items: [
        { url: '/billings/students', text: 'Students', class: '', icon: 'micon bi bi-receipt', models: [:billing] },
        { url: '/payments', text: 'Payments', class: '', icon: 'micon bi bi-credit-card', models: [Receipt, :payment] },
        { url: '/receipts', text: 'Receipts', class: '', icon: 'micon bi bi-receipt', models: [Receipt, :billing] },
        { url: '/notices', text: 'Notices', class: '', icon: 'micon bi bi-bell', models: [Notice, :billing] }

      ] },
      { url: '/communication', text: 'Communication', class: '', icon: 'micon bi bi-chat-text-fill', models: [:communication], sub_items: [] },
      { text: 'Reports', class: '', icon: 'micon bi bi-bar-chart-line-fill', sub_items: [
        { text: 'Graph Report', class: '', icon: 'micon bi bi-bar-chart-line-fill', models: [TrajectoryDetail, Book, Grade], sub_items: [
          { url: '/reports/graph', text: 'Trajectories', class: '', icon: 'micon bi bi-graph-up-arrow', models: [TrajectoryDetail] },
          { url: '/reports/books', text: 'Books', class: '', icon: 'micon bi bi-graph-up-arrow', models: [Book] },
          { url: '/reports/grades', text: 'Grades', class: '', icon: 'micon bi bi-graph-up-arrow', models: [Grade] }
        ] },
        { url: '/reports/daily', text: 'Daily Report', class: '', icon: 'micon bi bi-graph-up-arrow', models: [:reports] },
        { url: '/reports/student', text: 'Student Report', class: '', icon: 'micon bi bi-graph-up-arrow', models: [:reports] }
      ] }
    ]
    @menu_list = {
      General: [],
      Settings: []
    }

    general_items.each do |item|
      if item[:sub_items].present?
        item[:items] ||= []
        item[:sub_items].each do |sitem|
          next if sitem[:models].blank?

          filtered = sitem[:models].filter do |mdl|
            sitem if can? :read, mdl
          end

          if sitem[:sub_items].present?
            sitem[:items] ||= []
            sitem[:sub_items].each do |titem|
              next if titem[:models].blank?

              tfiltered = titem[:models].filter do |tmdl|
                titem if can? :read, tmdl
              end

              sitem[:items].push(titem) if tfiltered.any?
            end
          end

          item[:items].push(sitem) if filtered.any?
        end
        @menu_list[:General].push(item) if item[:items].any?
      else
        filtered = item[:models].filter do |mdl|
          item if can? :read, mdl
        end
        @menu_list[:General].push(item) if filtered.any?
      end
    end

    settings.each do |setting|
      @menu_list[:Settings].push(setting) if can? :read, setting[:model]
    end
    @menu_list[:Settings].push({ url: '/profile', text: 'Profile', class: '', icon: 'micon bi bi-person-circle' })
  end

  def fetch_notifications
    return if current_user.blank?

    @header_notifications = current_user.notifications.includes(record: [klass: :teacher]).order(created_at: :desc).limit(5)
  end

  def set_layout
    if user_signed_in?
      'application'
    else
      'welcome'
    end
  end

  def export
    records = current_account.send(params[:controller])

    respond_to do |format|
      format.csv { send_data records.to_csv, filename: "#{records.model.name}-#{Time.zone.today}.csv" }
    end
  end

  def show
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 5)

    model_name = controller_name == 'staffs' ? 'users' : controller_name
    @record = model_name.classify.constantize.find_by(id: params[:id])

    search = @record.versions.ransack(params[:q])
    search.sorts = 'created_at desc' if search.sorts.empty?
    @pagy, @changes = pagy(search.result, items: per_page)
  end

  private

  def set_time_zone(&block)
    Time.use_zone(current_account.timezone, &block)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash_message(:error, exception.message)
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
      format.js { render 'shared/flash' }
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
