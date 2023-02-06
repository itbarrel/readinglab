# frozen_string_literal: true

class EmailsController < ApplicationController
  def notify
    email_data = email_params

    if params[:record_type] == 'staffs'
      User.where(id: params[:record_ids]).find_each(batch_size: 10) do |record|
        StaffMailer.mailer(record, email_data).deliver
      end
    end

    if params[:record_type] == 'students'
      Student.where(id: params[:record_ids]).find_each(batch_size: 10) do |record|
        ParentMailer.mailer(record, email_data).deliver
      end
    end
    return unless params[:record_type] == 'klasses'

    student_ids = StudentClass.where(klass_id: params[:record_ids]).map(&:student_id)

    Student.where(id: student_ids).find_each(batch_size: 10) do |record|
      ParentMailer.mailer(record, email_data).deliver
    end
  end

  def description
    message_template = MessageTemplate.find_by(name: params[:name])
    render json: message_template.try(:description)
  end

  private

  def email_params
    params.permit(:title, :message)
  end
end
