# frozen_string_literal: true

class PaymentsController < ApplicationController
  # load_and_authorize_resource
  before_action :set_payment, only: %i[]

  # GET /payments or /payments.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 30)

    @meetings = Meeting.none

    if params[:student_id].present?
      @student =  current_account.students.find_by(id: params[:student_id])
      meeting_ids = @student.meetings.ids
      @payment_meeting_ids = @student.payments.map(&:meeting_id)

      @meetings = current_account.meetings.unscoped.where(id: meeting_ids + @payment_meeting_ids)
    end

    @search = @meetings.ransack(params[:q])
    @search.sorts = 'starts_at asc' if @search.sorts.empty?
    @pagy, @meetings = pagy(@search.result.includes([:klass]), items: per_page)
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
    checked = params[:checked]
    meeting_id = params[:meeting_id]
    student_id = params[:student_id]

    if true?(checked)
      Payment.find_or_create_by(student_id:, meeting_id:)
      flash[:notice] = 'Payment added.'
    else
      Payment.where(student_id:, meeting_id:).delete_all
      flash[:notice] = 'Payment deleted.'
    end
    respond_to do |format|
      format.js { render 'shared/flash' }
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
