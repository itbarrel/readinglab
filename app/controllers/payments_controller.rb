# frozen_string_literal: true

class PaymentsController < ApplicationController
  # load_and_authorize_resource
  before_action :set_payment, only: %i[]

  # GET /payments or /payments.json
  def index
    #  per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    #  @search = @payments.ransack(params[:q])
    #  @search.sorts = 'father_first asc' if @search.sorts.empty?
    #  @pagy, @paymentss = pagy(@search.result.includes(), items: per_page)
  end

  # GET /payments/1 or /payments/1.json
  def show; end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /pauments/1/edit
  def edit; end

  # POST /payments or /payments.json
  def create
    @payment = current_account.payments.new(payment_params)
    attach_account_for(@payment)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to request.referer, notice: 'payment has been successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        process_errors(@payment)
        format.html { redirect_to request.referer }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: 'payment has been successfully updated.' }
        format.json { render :index, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /books/1.json
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'session has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = current_account.payments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:student_id, :meeting_id, :klass_id)
  end
end
