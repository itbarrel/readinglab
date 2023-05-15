# frozen_string_literal: true

class MeetingsController < ApplicationController
  load_and_authorize_resource
  # before_action :set_meeting, only: %i[open_attendance submit_attendance]
  before_action :set_student, only: %i[student_details form_details]
  before_action :set_form, only: %i[student_details form_details]

  # GET /meetings or /meetings.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    if params[:start].present?
      start_date = params[:start]
      @meetings = @meetings.where(
        '(meetings.starts_at)::date >= ?', start_date.to_date
      )
    end

    if params[:end].present?
      end_date = params[:end]
      @meetings = @meetings.where(
        '(meetings.ends_at)::date <= ?', end_date.to_date
      )
    end

    if params[:teacher_id].present? && validate_uuid_format(params[:teacher_id])
      @meetings = @meetings.joins(:klass).where(klass: { teacher_id: params[:teacher_id] })
    end

    @pagy, @meetings = pagy(@meetings.includes(klass: %i[teacher room]), items: per_page)
  end

  def show; end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  def open_attendance
    klass = @meeting.klass
    @form = klass.attendance_form
    @students = klass.students
  end

  def submit_attendance
    return if params[:meeting].blank?

    params[:meeting].each do |student_id, submission|
      continue if submission['attendance'].blank?

      StudentMeeting.find_or_create_by!(meeting_id: @meeting.id, student_id:, account: current_account)
                    .update(attendance: submission['attendance'])
    end

    flash[:notice] = 'Attendance submitted successfully.'
    respond_to do |format|
      format.js { render 'shared/close_modal' }
    end
  end

  def open_form
    klass = @meeting.klass
    @form = Form.find(params[:form_id])

    students_class_ids = klass.student_forms
                              .where(klass_form_id: @form.klass_forms.ids)
                              .pluck(:student_class_id)

    @students = StudentClass.where(id: students_class_ids).map(&:student)
  end

  def open_student_details; end

  def save_form
    return if params[:form_details].blank?

    params[:form_details].each do |student_id, submission|
      fd = FormDetail.find_or_create_by!(
        user: current_user,
        student_id:,
        form_id: params[:form_id],
        parent_type: 'Meeting',
        parent_id: @meeting.id,
        account: current_account
      )

      fd.update(form_values: submission) unless fd.submitted
    end

    flash[:notice] = 'Form Data saved successfully.'
    respond_to do |format|
      format.js { render 'shared/close_modal' }
    end
  end

  def submit_form
    return if params[:form_details].blank?

    params[:form_details].each do |student_id, submission|
      fd = FormDetail.find_or_create_by!(
        user: current_user,
        student_id:,
        form_id: params[:form_id],
        parent_type: 'Meeting',
        parent_id: @meeting.id,
        account: current_account
      )
      fd.update(form_values: submission, submitted: true) unless fd.submitted
    end

    flash[:notice] = 'Form Data submitted successfully.'
    respond_to do |format|
      format.js { render 'shared/close_modal' }
    end
  end

  def student_details
    @student = Student.find_by(id: params[:student_id])
  end

  def form_details
    meetings = Meeting
               .joins(:form_details)
               .where('starts_at < ?', @meeting.starts_at)
               .where(form_details: { student_id: @student.id, form_id: @form.id })
               .order(starts_at: :desc).distinct.limit(3)
    @form_details = meetings.map do |meeting|
      meeting.form_details.filter  do |fd|
        fd.student_id == @student.id && fd.form_id == @form.id
      end
    end.flatten
  end

  def edit; end

  def create
    @meeting = current_account.meetings.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meetings_url, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { redirect_to meetings_url }
        format.json { render json: @meeting.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        flash[:notice] = 'Meeting has been successfully updated.'
        format.html { redirect_to meeting_url(@meeting), notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
        format.js { render 'shared/flash' }
      else
        format.html { redirect_to meetings_url }
        format.json { render json: @meeting.errors }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meeting
    @meeting = current_account.meetings.find_by(id: params[:id])
  end

  def set_student
    @student = current_account.students.find_by(id: params[:student_id])
  end

  def set_form
    @form = current_account.forms.find_by(id: params[:form_id])
  end

  # Only allow a list of trusted parameters through.
  def meeting_params
    params.require(:meeting).permit(:starts_at, :cancel, :klass_id, :form_id)
  end
end
