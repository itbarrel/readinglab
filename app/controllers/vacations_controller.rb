# frozen_string_literal: true

class VacationsController < ApplicationController
  load_and_authorize_resource except: [:index]
  before_action :set_vacation, only: %i[show]
  before_action :set_vacations, only: %i[trash]

  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @vacations = current_account.vacations.accessible_by(current_ability)
    @search = @vacations.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @vacations = pagy(@search.result.includes(:vacation_type), items: per_page)
  end

  def show; end

  def new
    @vacation = current_account.vacations.new
  end

  # GET /vacations/1/edit
  def edit; end

  # POST /vacations or /vacations.json
  def create
    @vacation = current_account.vacations.new(vacation_params)

    respond_to do |format|
      if @vacation.save
        format.html { redirect_to vacations_url, notice: 'Vacation has been successfully created.' }
        format.json { render :show, status: :created, location: @vacation }
      else
        process_errors(@vacation)
        format.html { redirect_to vacations_url }
        format.json { render json: vacation.errors }
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
        format.html { redirect_to vacations_url }
        format.json { render json: @vacation.errors }
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
    @vacations.destroy_all
    flash[:notice] = 'Vacations has been successfully Deleted.'
    render js: "window.location = '#{vacations_url}'"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vacation
    @vacation = current_account.vacations.find(params[:id])
  end

  def set_vacations
    @vacations = current_account.vacations.where(id: params[:ids])
  end

  def vacation_params
    params.require(:vacation).permit(:name, :starting_at, :ending_at, :vacation_type_id)
  end
end
