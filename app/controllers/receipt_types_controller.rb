class ReceiptTypesController < ApplicationController
  before_action :set_receipt_type, only: %i[ show edit update destroy ]

  # GET /receipt_types or /receipt_types.json
  def index
    @receipt_types = ReceiptType.all
  end

  # GET /receipt_types/1 or /receipt_types/1.json
  def show
  end

  # GET /receipt_types/new
  def new
    @receipt_type = ReceiptType.new
  end

  # GET /receipt_types/1/edit
  def edit
  end

  # POST /receipt_types or /receipt_types.json
  def create
    @receipt_type = ReceiptType.new(receipt_type_params)

    respond_to do |format|
      if @receipt_type.save
        format.html { redirect_to receipt_type_url(@receipt_type), notice: "Receipt type was successfully created." }
        format.json { render :show, status: :created, location: @receipt_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @receipt_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receipt_types/1 or /receipt_types/1.json
  def update
    respond_to do |format|
      if @receipt_type.update(receipt_type_params)
        format.html { redirect_to receipt_type_url(@receipt_type), notice: "Receipt type was successfully updated." }
        format.json { render :show, status: :ok, location: @receipt_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @receipt_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipt_types/1 or /receipt_types/1.json
  def destroy
    @receipt_type.destroy

    respond_to do |format|
      format.html { redirect_to receipt_types_url, notice: "Receipt type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt_type
      @receipt_type = ReceiptType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def receipt_type_params
      params.require(:receipt_type).permit(:name, :active, :deleted_at, :account_id)
    end
end