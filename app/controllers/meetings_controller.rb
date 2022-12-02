# frozen_string_literal: true

class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[show edit update destroy]

  # GET /meetings or /meetings.json
  def index
    @meetings = Meeting.all

    if params[:start].present?
      start_date = params[:start]
      @meetings = @meetings.where(
        '(starts_at)::date > ?', start_date.to_date
      )
    end

    if params[:end].present?
      end_date = params[:end]
      @meetings = @meetings.where(
        '(ends_at)::date < ?', end_date.to_date
      )
    end

    @pagy, @meetings = pagy(@meetings.includes(:klass), items: params[:per_page] || '10')
  end

  # GET /meetings/1 or /meetings/1.json
  def show; end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit; end

  # POST /meetings or /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meeting_url(@meeting), notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meeting_url(@meeting), notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
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
    @meeting = Meeting.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def meeting_params
    params.require(:meeting).permit(:start, :cancel, :deleted_at, :active, :account_id, :klass_id, :form_id)
  end
end
