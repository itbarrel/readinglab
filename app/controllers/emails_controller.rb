# frozen_string_literal: true

class EmailsController < ApplicationController
  def notify
    if params[:record_type] == 'staffs'
      email_data = { title: params[:title], predefined: params[:predefined], message: params[:message] }
      staff = User.find(params[:record_ids])
      StaffMailer.staff_mailer(staff, email_data).deliver
    end
    return unless params[:record_type] == 'students'

    email_data = { title: params[:title], predefined: params[:predefined], message: params[:message] }
    parent = Student.find(params[:record_ids]).map(&:parent)
    ParentMailer.klass_mailer(parent, email_data).deliver
  end
end
