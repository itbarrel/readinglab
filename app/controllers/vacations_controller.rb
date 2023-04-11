# frozen_string_literal: true

class VacationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_vacation, only: %i[]
  before_action :set_vacations, only: %i[trash]

  # GET /vacations or /vacations.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @vacations.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @vacations = pagy(@search.result, items: per_page)
  end

  # GET /vacations/1 or /vacations/1.json
  def show; end

  # GET /vacations/new
  def new
    @vacation = current_account.vacations.new
  end

  # GET /vacations/1/edit
  def edit; end

  # POST /vacations or /vacations.json
  def create
    @vacation = current_account.vacations.new(vacation_params)
    attach_account_for(@vacation)

    respond_to do |format|
      if @vacation.save
        format.html { redirect_to vacations_url, notice: 'Vacation has been successfully created.' }
        format.json { render :show, status: :created, location: @vacation }
      else
        process_errors(@vacation)
        format.html { redirect_to vacations_url }
        format.json { render json: vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacations/1 or /vacations/1.json
  def update
    respond_to do |format|
      if @vacation.update(vacation_params)
        format.html { redirect_to vacations_url, notice: 'Message has been successfully updated.' }
        format.json { render :show, status: :ok, location: @vacation }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vacation.destroy

    respond_to do |format|
      format.html { redirect_to vacations_url, notice: 'Vacation has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def trash
    flash[:notice] = 'vacations has been successfully Deleted.'
    render js: "window.location = '#{vacations_url}'"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vacation
    @vacation = current_account.vacations.find(params[:id])
  end

  def set_vacations
    @vacations = current_account.vacations.find(params[:ids])
  end

  def vacation_params
    params.require(:vacation).permit(:name, :starting_at, :ending_at, :vacation_type_id)
  end
end
