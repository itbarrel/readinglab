# frozen_string_literal: true

class InterviewsController < ApplicationController
  load_and_authorize_resource
  before_action :set_interview, only: %i[show edit update destroy]

  # GET /interviews or /interviews.json
  def index
    if params[:start].present?
      start_date = params[:start]
      @interviews = @interviews.where(
        '(date)::date > ?', start_date.to_date
      )
    end

    if params[:end].present?
      end_date = params[:end]
      @interviews = @interviews.where(
        '(date)::date < ?', end_date.to_date
      )
    end

    @search = @interviews.ransack(params[:q])
    @search.sorts = 'student_first_name asc' if @search.sorts.empty?
    @pagy, @interviews = pagy(@search.result.includes(:student),
                              items: params[:per_page] || '10')
  end

  # GET /interviews/1 or /interviews/1.json
  def show; end

  # GET /interviews/new
  def new
    # @interview = Interview.new
  end

  # GET /interviews/1/edit
  def edit; end

  # POST /interviews or /interviews.json
  def create
    @interview = Interview.new(interview_params)
    attach_account_for(@interview)
    respond_to do |format|
      if @interview.save
        format.html { redirect_to interviews_url, notice: 'Interview was successfully created.' }
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
        format.html { redirect_to interviews_url, notice: 'Interview was successfully updated.' }
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
      format.html { redirect_to interviews_url, notice: 'Interview was successfully destroyed.' }
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
    params.require(:interview).permit(:date, :feedback, :status, :deleted_at, :active, :account_id, :form_id,
                                      :student_id)
  end
end
