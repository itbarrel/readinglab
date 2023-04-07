# frozen_string_literal: true

class ReceiptsController < ApplicationController
  load_and_authorize_resource
  before_action :set_receipt, only: %i[]

  # GET /receipts or /receipts.json
  def index
    @search = @receipts.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @receipts = pagy(@search.result.includes(:student, :receipt_type),
                            items: params[:per_page] || '10')
  end

  # GET /receipts/1 or /receipts/1.json
  def show; end

  # GET /receipts/new
  def new
    @receipt = Receipt.new
  end

  # GET /receipts/1/edit
  def edit; end

  # POST /receipts or /receipts.json
  def create
    @receipt = Receipt.new(receipt_params)
    attach_account_for(@receipt)
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_receipt
    @receipt = Receipt.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def receipt_params
    params.require(:receipt).permit(:amount, :leave_count, :detail, :discount, :student_id, :account,
                                    :discount_reason, :sessions_count, :user_id, :receipt_type_id)
  end
end
