# frozen_string_literal: true

class ReceiptTypesController < ApplicationController
  load_and_authorize_resource
  before_action :set_receipt_type, only: %i[]
  before_action :set_receipt_types, only: %i[trash]

  # GET /receipt_types or /receipt_types.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @receipt_types.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @receipt_types = pagy(@search.result, items: per_page)
  end

  # GET /receipt_types/1 or /receipt_types/1.json
  def show; end

  # GET /receipt_types/new
  def new
    @receipt_type = current_account.receipt_types.new
  end

  # GET /receipt_types/1/edit
  def edit; end

  # POST /receipt_types or /receipt_types.json
  def create
    @receipt_type = current_account.receipt_types.new(receipt_type_params)

    respond_to do |format|
      if @receipt_type.save
        format.html { redirect_to receipt_types_url, notice: 'Receipt type has been successfully created.' }
        format.json { render :show, status: :created, location: @receipt_type }
      else
        process_errors(@receipt_type)
        format.html { redirect_to receipt_types_url }
        format.json { render json: @receipt_type.errors }
      end
    end
  end

  # PATCH/PUT /receipt_types/1 or /receipt_types/1.json
  def update
    respond_to do |format|
      if @receipt_type.update(receipt_type_params)
        format.html { redirect_to receipt_types_url, notice: 'Receipt type has been successfully updated.' }
        format.json { render :show, status: :ok, location: @receipt_type }
      else
        format.html { redirect_to receipt_types_url }
        format.json { render json: @receipt_type.errors }
      end
    end
  end

  # DELETE /receipt_types/1 or /receipt_types/1.json
  def destroy
    @receipt_type.destroy

    respond_to do |format|
      format.html { redirect_to receipt_types_url, notice: 'Receipt type has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def trash
    @receipt_types.destroy_all
    flash[:notice] = 'receipt_types has been successfully Deleted.'
    render js: "window.location = '#{receipt_types_url}'"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_receipt_type
    @receipt_type = current_account.receipt_types.find(params[:id])
  end

  def set_receipt_types
    @receipt_types = current_account.receipt_types.where(id: params[:ids])
  end

  # Only allow a list of trusted parameters through.
  def receipt_type_params
    params.require(:receipt_type).permit(:name)
  end
end
