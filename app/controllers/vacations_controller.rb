# frozen_string_literal: true

class VacationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_vacation, only: %i[show edit update destroy]

  # GET /vacations or /vacations.json
  def index
    # @vacations = Vacation.all
    @search = @vacations.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @vacations = pagy(@search.result,
                             items: params[:per_page] || '10')
  end

  # GET /vacations/1 or /vacations/1.json
  def show; end

  # GET /vacations/new
  def new
    @vacation = Vacation.new
  end

  # GET /vacations/1/edit
  def edit; end

  # POST /vacations or /vacations.json
  def create
    @vacation = Vacation.new(vacation_params)

    respond_to do |format|
      if @vacation.save
        format.html { redirect_to vacation_url(@vacation), notice: 'Vacation was successfully created.' }
        format.json { render :show, status: :created, location: @vacation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacations/1 or /vacations/1.json
  def update
    respond_to do |format|
      if @vacation.update(vacation_params)
        format.html { redirect_to vacation_url(@vacation), notice: 'Vacation was successfully updated.' }
        format.json { render :show, status: :ok, location: @vacation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacations/1 or /vacations/1.json
  def destroy
    @vacation.destroy

    respond_to do |format|
      format.html { redirect_to vacations_url, notice: 'Vacation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vacation
    @vacation = Vacation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vacation_params
    params.require(:vacation).permit(:day, :name, :strating_at, :ending_at, :deleted_at, :vacation_type, :active,
                                     :boolean, :account_id, :references)
  end
end
