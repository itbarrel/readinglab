# frozen_string_literal: true

class ReceiptsController < ApplicationController
  load_and_authorize_resource
  before_action :set_receipt, only: %i[]
  before_action :set_receipts, only: %i[trash]

  # GET /receipts or /receipts.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @receipts.ransack(params[:q])
    @search.sorts = 'amount asc' if @search.sorts.empty?
    @pagy, @receipts = pagy(@search.result.includes(:student, :receipt_type), items: per_page)
  end

  # GET /receipts/1 or /receipts/1.json
  def show; end

  # GET /receipts/new
  def new
    @receipt = current_account.receipts.new
  end

  # GET /receipts/1/edit
  def edit; end

  # POST /receipts or /receipts.json
  def create
    @receipt = current_account.receipts.new(receipt_params)

    respond_to do |format|
      if @receipt.save
        format.html { redirect_to receipts_url, notice: 'Receipt has been successfully created.' }
        format.json { render :show, status: :created, location: @receipt }
      else
        process_errors(@receipt)
        format.html { render :index }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receipts/1 or /receipts/1.json
  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to receipts_url, notice: 'Receipt has been successfully updated.' }
        format.json { render :show, status: :created, location: @receipt }
      else
        format.html { redirect_to receipts_url }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1 or /receipts/1.json
  def destroy
    @receipt.destroy

    respond_to do |format|
      format.html { redirect_to receipts_url, notice: 'Receipt has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def trash
    flash[:notice] = 'receipts has been successfully Deleted.'
    render js: "window.location = '#{receipts_url}'"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_receipt
    @receipt = current_account.receipts.find(params[:id])
  end

  def set_receipts
    @receipts = current_account.receipts.find(params[:ids])
  end

  # Only allow a list of trusted parameters through.
  def receipt_params
    params.require(:receipt).permit(:amount, :leave_count, :detail, :discount, :student_id, :account,
                                    :discount_reason, :sessions_count, :user_id, :receipt_type_id)
  end
end
