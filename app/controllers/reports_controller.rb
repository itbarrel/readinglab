# frozen_string_literal: true

class ReportsController < ApplicationController
  def weekly_attendance
    start_of_week = Time.zone.today.beginning_of_week
    end_of_week = Time.zone.today.end_of_week
    end_of_last_week = (start_of_week - 1.week).end_of_day

    weekly_mapping = {}
    (start_of_week.to_date..end_of_week.to_date).each do |date|
      weekly_mapping[Date::DAYNAMES[date.wday]] = 0
    end

    this_week_meetings = current_account.student_meetings.includes(:meeting).present.where(meetings: { starts_at: start_of_week..end_of_week })
    last_week_meetings = current_account.student_meetings.includes(:meeting).present.where(meetings: { starts_at: end_of_last_week..start_of_week })

    if this_week_meetings.length >= last_week_meetings.length
      max = this_week_meetings.length
      min = last_week_meetings.length
      percentage_sign = '+'
    else
      max = last_week_meetings.length
      min = this_week_meetings.length
      percentage_sign = '-'
    end
    percentage = if min.zero?
                   max.zero? ? 0 : Float::INFINITY
                 else
                   (max.to_f / min) * 100
                 end.round(1)

    percentage = percentage == Float::INFINITY ? '∞' : percentage
    render json: {
      percentage:,
      total: this_week_meetings.length,
      percentage_sign:,
      data: weekly_mapping.merge!(this_week_meetings.group_by { |sm| Date::DAYNAMES[sm.meeting.starts_at.wday] }.transform_values(&:length))
    }
  end

  def weekly_receipts
    current_date = Time.zone.today
    weekly_mapping = {}
    total = 0

    6.times do |_date|
      monthly_amount = current_account.receipts.where(created_at: current_date.beginning_of_month..current_date.end_of_month).sum(:amount)
      weekly_mapping[Date::MONTHNAMES[current_date.month]] = monthly_amount
      current_date -= 1.month
      total += monthly_amount
    end

    current_ammount = weekly_mapping[Date::MONTHNAMES[Time.zone.today.month]]
    previous_ammount = weekly_mapping[Date::MONTHNAMES[(Time.zone.today - 1.month).month]]

    if current_ammount >= previous_ammount
      max = current_ammount
      min = previous_ammount
      percentage_sign = '+'
    else
      max = previous_ammount
      min = current_ammount
      percentage_sign = '-'
    end

    percentage = if min.zero?
                   max.zero? ? 0 : Float::INFINITY
                 else
                   (max.to_f / min) * 100
                 end.round(1)

    percentage = percentage == Float::INFINITY ? '∞' : percentage
    render json: {
      percentage:,
      total: total >= 1000 ? "#{(total / 1000).round(1)}K" : total,
      percentage_sign:,
      data: weekly_mapping
    }
  end

  def students
    student_mapping = {}

    total = Student.count

    Student.statuses.each do |status|
      student_mapping[status.first.humanize] = Student.where(status: status.second).size
    end

    # student_mapping['Deleted'] = Student.with_deleted.count

    render json: {
      total:,
      data: student_mapping
    }
  end

  def book
    @books = Book.all
  end

  def grade
    @grades = Grade.all
  end

  def graph; end

  def student_graph
    @trajectory_details = TrajectoryDetail.where(student_id: params[:id])
  end

  def daily; end

  def student
    return unless params[:search].present? && params[:search][:student_id].present?

    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 20)
    @from = params[:search][:from].presence || Date.new(2015, 1, 1)
    @to = params[:search][:to].presence || Time.zone.now

    @record = Student.find_by(id: params[:search][:student_id])
    meeting_ids = @record.meetings.where(starts_at: @from..@to).ids
    @search = @record.form_details.where(parent_type: 'Meeting', parent_id: meeting_ids).ransack(params[:q])

    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @pagy, @records = pagy(@search.result.includes(:parent, :form), items: per_page)
    # respond_to do |format|
    #   format.csv { send_data records.to_csv(options), filename: "#{records.model.name}-#{Time.zone.today}.csv" }
    # end
  end
end
