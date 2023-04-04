# frozen_string_literal: true

class InterviewsController < ApplicationController
  load_and_authorize_resource except: [:index]
  before_action :set_interview, only: %i[]

  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    interview_students = Student.joins(:latest_interview).distinct

    if params[:calendar].present?
      interview_students = interview_students.where(
        interviews: { status: :waiting }
      )
    end

    if params[:start].present?
      start_date = params[:start]
      interview_students = interview_students.where(
        '(interviews.date)::date > ?', start_date.to_date
      )
    end

    if params[:end].present?
      end_date = params[:end]
      interview_students = interview_students.where(
        '(interviews.date)::date < ?', end_date.to_date
      )
    end

    @search = interview_students.ransack(params[:q])
    @search.sorts = 'first_name asc' if @search.sorts.empty?
    @pagy, @interview_students = pagy(@search.result.includes(:latest_interview), items: per_page)
  end

  # GET /interviews/1 or /interviews/1.json
  def show; end

  # GET /interviews/new
  def new
    @interview.student_id = params[:student_id] if params[:student_id].present?
  end

  # GET /interviews/1/edit
  def edit; end

  # POST /interviews or /interviews.json
  def create
    @interview = Interview.new(interview_params)
    attach_account_for(@interview)
    respond_to do |format|
      if @interview.save
        format.html { redirect_to interviews_url, notice: 'Interview has been successfully created.' }
        format.json { render :show, status: :created, location: @interview }
      else
        format.html { redirect_to interviews_url, status: :unprocessable_entity }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interviews/1 or /interviews/1.json
  def update
    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to interviews_url, notice: 'Interview has been successfully updated.' }
        format.json { render :show, status: :ok, location: @interview }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviews/1 or /interviews/1.json
  def destroy
    @interview.destroy

    respond_to do |format|
      format.html { redirect_to interviews_url, notice: 'Interview has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_interview
    # @interview = Interview.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def interview_params
    params.require(:interview).permit(:date, :feedback, :status, :form_id,
                                      :student_id)
  end
end
