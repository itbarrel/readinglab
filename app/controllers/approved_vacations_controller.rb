# frozen_string_literal: true

class ApprovedVacationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_approved_vacation, only: %i[]
  before_action :set_approved_vacations, only: %i[trash]

  # GET /approved_vacations or /approved_vacations.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 15)

    @search = @approved_vacations.ransack(params[:q])
    @search.sorts = 'starts_date desc' if @search.sorts.empty?
    @pagy, @approved_vacations = pagy(@search.result.includes(:student), items: per_page)
  end

  def show; end

  def new;  end

  def edit; end

  def create
    @approved_vacation = current_account.approved_vacations.new(approved_vacation_params)

    respond_to do |format|
      if @approved_vacation.save
        format.html { redirect_to approved_vacations_url, notice: 'vacation has been successfully approved.' }
        format.json { render :show, status: :created, location: @approved_vacation }
      else
        process_errors(@approved_vacation)
        format.html { redirect_to approved_vacations_url }
        format.json { render json: @approved_vacation.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @approved_vacation.update(approved_vacation_params)
        format.html { redirect_to approved_vacations_url, notice: 'successfully updated.' }
        format.json { render :show, status: :ok, location: @approved_vacation }
      else
        process_errors(@approved_vacation)
        format.html { redirect_to approved_vacations_url }
        format.json { render json: @approved_vacation.errors }
      end
    end
  end

  # DELETE /approved_vacations/1 or /approved_vacations/1.json
  def destroy
    @approved_vacation.destroy

    respond_to do |format|
      format.html { redirect_to approved_vacations_url, notice: 'Approved vacation successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def trash
    @approved_vacations.destroy_all
    flash[:notice] = 'Approved vacation has been successfully Deleted.'
    render js: "window.location = '#{approved_vacations_url}'"
  end

  private

  def set_approved_vacation
    @approved_vacation = current_account.approved_vacations.find(params[:id])
  end

  def set_approved_vacations
    @approved_vacations = current_account.approved_vacations.where(id: params[:ids])
  end

  # Only allow a list of trusted parameters through.
  def approved_vacation_params
    params.require(:approved_vacation).permit(:name, :reason, :start_date, :end_date, :student_id, :account_id)
  end
end
