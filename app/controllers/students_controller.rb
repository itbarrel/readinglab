# frozen_string_literal: true

class StudentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_student, only: %i[]
  before_action :set_students, only: %i[trash]

  # GET /students or /students.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    params[:classes_at].present? && @students = current_account.students.studing_at(params[:classes_at].to_datetime)

    @search = @students.ransack(params[:q])
    @search.sorts = 'first_name asc' if @search.sorts.empty?
    @pagy, @students = pagy(@search.result.includes(:parent), items: per_page)
  end

  def present_search
    if params[:search][:date].present?
      present_student = params[:search][:date]
      @present_student = Student.studing_at(present_student)
    end

    redirect_to communication_path
  end

  # GET /students/1 or /students/1.json
  def show; end

  # GET /students/new
  def new
    @student.parent_id = params[:parent_id] if params[:parent_id].present?
  end

  # GET /students/1/edit
  def edit; end

  # POST /students or /students.json
  def create
    @student = current_account.students.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to students_url, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        process_errors(@student)
        format.html { redirect_to students_url }
        format.json { render json: @student.errors }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to students_url, notice: 'Student has been successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { redirect_to students_url }
        format.json { render json: @student.errors }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def trash
    @students.destroy_all
    flash[:notice] = 'students has been successfully Deleted.'
    render js: "window.location = '#{students_url}'"
  end

  def interviews; end

  # modal
  def student_attendance
    calculate_attendance_for(@student)
  end

  # table
  def student_attendance_search
    calculate_attendance_for(@student, params[:search][:from], params[:search][:to])
    respond_to do |format|
      format.js
    end
  end

  def calculate_attendance_for(student, from = Time.zone.today.beginning_of_month, to = Time.zone.today)
    meeting_ids = current_account.meetings.working.where(starts_at: from..to).ids
    @student_attendance = student.student_meetings.where(meeting_id: meeting_ids)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = current_account.students.find(params[:id])
  end

  def set_students
    @students = current_account.students.where(id: params[:ids])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:first_name, :last_name, :dob, :grade, :school, :gender, :settings,
                                    :dates, :programs, :status, :parent_id,
                                    :prepaid_sessions, :credit_session, :registration_date)
  end
end
