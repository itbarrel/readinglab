# frozen_string_literal: true

class StudentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_student, only: %i[]

  # GET /students or /students.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    params[:classes_at].present? && @students = Student.studing_at(params[:classes_at].to_datetime)

    @search = @students.ransack(params[:q])
    @search.sorts = 'first_name asc' if @search.sorts.empty?
    @pagy, @students = pagy(@search.result, items: per_page)
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
        format.html { redirect_to student_url, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = current_account.students.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:first_name, :last_name, :dob, :grade, :school, :sex, :settings,
                                    :dates, :programs, :status,
                                    :prepaid_sessions, :credit_session, :registration_date)
  end
end
