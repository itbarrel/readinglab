# frozen_string_literal: true

class ReportsController < ApplicationController
  def graph; end

  def weekly_attendance
    start_of_week = Time.zone.today.beginning_of_day
    end_of_week = (start_of_week - 7.days).end_of_day
    end_of_last_week = (start_of_week - 14.days).end_of_day

    weekly_mapping = {}
    (end_of_week.to_date..start_of_week.to_date).each do |date|
      weekly_mapping[date] = 0
    end

    this_week_meetings = current_account.student_meetings.includes(:meeting).present.where(meetings: { starts_at: end_of_week..start_of_week })
    last_week_meetings = current_account.student_meetings.includes(:meeting).present.where(meetings: { starts_at: end_of_last_week..end_of_week })

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
                 end

    percentage = percentage == Float::INFINITY ? '∞' : percentage
    render json: {
      percentage:,
      total: this_week_meetings.length,
      percentage_sign:,
      data: weekly_mapping.merge!(this_week_meetings.group_by { |sm| sm.meeting.starts_at.to_date }.transform_values(&:length))
    }
  end

  def daily; end

  def student
    return unless params[:search].present? && params[:search][:student_id].present?

    from = params[:search][:from] || Date.new(2015, 1, 1)
    to = params[:search][:to] || Time.zone.now
    options = {
      from:,
      to:
    }
    records = Student.where(id: (params[:search][:student_id]))
    respond_to do |format|
      format.csv { send_data records.to_csv(options), filename: "#{records.model.name}-#{Time.zone.today}.csv" }
    end
  end
end
