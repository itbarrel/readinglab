# frozen_string_literal: true

class VacationTypesController < ApplicationController
  before_action :set_vacation_type, only: %i[show edit update destroy]

  # GET /vacation_types or /vacation_types.json
  def index
    @vacation_types = VacationType.all
  end

  # GET /vacation_types/1 or /vacation_types/1.json
  def show; end

  # GET /vacation_types/new
  def new
    @vacation_type = VacationType.new
  end

  # GET /vacation_types/1/edit
  def edit; end

  # POST /vacation_types or /vacation_types.json
  def create
    @vacation_type = VacationType.new(vacation_type_params)

    respond_to do |format|
      if @vacation_type.save
        format.html { redirect_to vacation_type_url(@vacation_type), notice: 'Vacation type was successfully created.' }
        format.json { render :show, status: :created, location: @vacation_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vacation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacation_types/1 or /vacation_types/1.json
  def update
    respond_to do |format|
      if @vacation_type.update(vacation_type_params)
        format.html { redirect_to vacation_type_url(@vacation_type), notice: 'Vacation type was successfully updated.' }
        format.json { render :show, status: :ok, location: @vacation_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vacation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacation_types/1 or /vacation_types/1.json
  def destroy
    @vacation_type.destroy

    respond_to do |format|
      format.html { redirect_to vacation_types_url, notice: 'Vacation type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vacation_type
    @vacation_type = VacationType.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vacation_type_params
    params.require(:vacation_type).permit(:name, :description, :boolean,
                                          :references)
  end
end
