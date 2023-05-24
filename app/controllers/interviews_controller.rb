# frozen_string_literal: true

class InterviewsController < ApplicationController
  load_and_authorize_resource except: [:index]
  before_action :set_interview, only: %i[]
  before_action :set_interviews, only: %i[trash]

  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    interview_students = current_account.students.joins(:latest_interview).distinct

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

  def open_form
    @form = @interview.form
    @students = current_account.students.where(id: @interview.student_id)
  end

  def submit_form
    return if params[:form_details].blank?

    params[:form_details].each do |student_id, submission|
      FormDetail.find_or_create_by!(
        user: current_user,
        student_id:,
        form_id: params[:form_id],
        parent_type: 'Interview',
        parent_id: @interview.id,
        account: current_account
      )
                .update(form_values: submission)
    end
    # marked interview closed

    flash[:notice] = 'Assessment Form Data submitted successfully.'
    respond_to do |format|
      format.js
    end
  end

  # POST /interviews or /interviews.json
  def create
    @interview = current_account.interviews.new(interview_params)

    respond_to do |format|
      if @interview.save
        format.html { redirect_to interviews_url, notice: 'Interview has been successfully created.' }
        format.json { render :show, status: :created, location: @interview }
      else
        process_errors(@interview)
        format.html { redirect_to interviews_url }
        format.json { render json: @interview.errors }
      end
    end
  end

  # PATCH/PUT /interviews/1 or /interviews/1.json
  def update
    respond_to do |format|
      if @interview.update(interview_params)
        flash[:notice] = 'Assessment Cancelled successfully.' if @interview.cancel?
        format.html { redirect_to interviews_url, notice: 'Interview has been successfully updated.' }
        format.json { render :show, status: :ok, location: @interview }
      else
        process_errors(@interview)
        format.html { redirect_to interviews_url }
        format.json { render json: @interview.errors }
      end
      format.js
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

  def trash
    @interviews.destroy_all
    flash[:notice] = 'interviews has been successfully Deleted.'
    render js: "window.location = '#{interviews_url}'"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_interview
    # @interview = Interview.find(params[:id])
  end

  def set_interviews
    @interviews = current_account.interviews.where(id: params[:ids])
  end

  # Only allow a list of trusted parameters through.
  def interview_params
    params.require(:interview).permit(:date, :feedback, :status, :form_id,
                                      :student_id)
  end
end
