# frozen_string_literal: true

class StudentMettingsController < ApplicationController
  before_action :set_student_metting, only: %i[show edit update destroy]

  # GET /student_mettings or /student_mettings.json
  def index
    @student_mettings = StudentMetting.all
  end

  # GET /student_mettings/1 or /student_mettings/1.json
  def show; end

  # GET /student_mettings/new
  def new
    @student_metting = StudentMetting.new
  end

  # GET /student_mettings/1/edit
  def edit; end

  # POST /student_mettings or /student_mettings.json
  def create
    @student_metting = StudentMetting.new(student_metting_params)

    respond_to do |format|
      if @student_metting.save
        format.html do
          redirect_to student_metting_url(@student_metting), notice: 'Student metting was successfully created.'
        end
        format.json { render :show, status: :created, location: @student_metting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student_metting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_mettings/1 or /student_mettings/1.json
  def update
    respond_to do |format|
      if @student_metting.update(student_metting_params)
        format.html do
          redirect_to student_metting_url(@student_metting), notice: 'Student metting was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @student_metting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student_metting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_mettings/1 or /student_mettings/1.json
  def destroy
    @student_metting.destroy

    respond_to do |format|
      format.html { redirect_to student_mettings_url, notice: 'Student metting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student_metting
    @student_metting = StudentMetting.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_metting_params
    params.fetch(:student_metting, {})
  end
end
