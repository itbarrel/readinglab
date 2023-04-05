# frozen_string_literal: true

class VacationTypesController < ApplicationController
  load_and_authorize_resource
  before_action :set_vacation_type, only: %i[]

  # GET /vacation_types or /vacation_types.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @vacation_types.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @vacation_types = pagy(@search.result, items: per_page)
  end

  # GET /vacation_types/1 or /vacation_types/1.json
  def show; end

  # GET /vacation_types/new
  def new
    @vacation_type = current_account.vacation_types.new
  end

  # GET /vacation_types/1/edit
  def edit; end

  # POST /vacation_types or /vacation_types.json
  def create
    @vacation_type = current_account.vacation_types.new(vacation_type_params)

    respond_to do |format|
      if @vacation_type.save
        format.html { redirect_to vacation_type_url(@vacation_type), notice: 'Vacation has been successfully created.' }
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
        format.html { redirect_to vacation_type_url(@vacation_type), notice: 'Vacation has been successfully updated.' }
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
      format.html { redirect_to vacation_types_url, notice: 'Vacation has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vacation_type
    @vacation_type = current_account.vacation_types.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vacation_type_params
    params.require(:vacation_type).permit(:name, :description)
  end
end
