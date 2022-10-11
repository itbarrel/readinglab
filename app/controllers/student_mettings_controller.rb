# frozen_string_literal: true

class StudentMeetingsController < ApplicationController
  before_action :set_student_meetings, only: %i[show edit update destroy]

  # GET /student_meetings or /student_meetings.json
  def index
    @student_meeting = StudentMeeting.all
  end

  # GET /student_meetings/1 or /student_meetings/1.json
  def show; end

  # GET /student_meetings/new
  def new
    @student_meeting = StudentMeeting.new
  end

  # GET /student_meetings/1/edit
  def edit; end

  # POST /student_meetings or /student_meetings.json
  def create
    @student_meetings = StudentMeeting.new(student_meetings_params)

    respond_to do |format|
      if @student_meetings.save
        format.html do
          redirect_to student_meeting_url(@student_meeting), notice: 'Student meeting was successfully created.'
        end
        format.json { render :show, status: :created, location: @student_meeting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student_meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_meetings/1 or /student_meetings/1.json
  def update
    respond_to do |format|
      if @student_meeting.update(student_meeting_params)
        format.html do
          redirect_to student_meeting_url(@student_meeting), notice: 'Student meeting was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @student_meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student_meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_meetings/1 or /student_meetings/1.json
  def destroy
    @student_meeting.destroy

    respond_to do |format|
      format.html { redirect_to student_meetings_url, notice: 'Student meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student_meeting
    @student_meeting = StudentMeeting.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_meeting_params
    params.fetch(:student_meeting, {})
  end
end
