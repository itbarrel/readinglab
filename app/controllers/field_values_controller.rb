# frozen_string_literal: true

class FieldValuesController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  # GET /field_values or /field_values.json
  def index
    @field_values = FieldValue.all
  end

  # GET /field_values/1 or /field_values/1.json
  def show; end

  # GET /field_values/new
  def new
    @field_values = FormField.new
  end

  # GET /field_values/1/edit
  def edit; end

  # POST /field_values or /field_values.json
  def create
    @field_values = FormField.new(field_value_params)

    respond_to do |format|
      if @field_values.save
        format.html { redirect_to book_url(@field_values), notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @field_values }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @field_values.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /field_values/1 or /field_values/1.json
  def update
    respond_to do |format|
      if @field_values.update(field_value_params)
        format.html { redirect_to book_url(@field_values), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @field_values }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @field_values.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /field_values/1 or /field_values/1.json
  def destroy
    @field_values.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @field_values = FormField.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def field_value_params
    params.require(:form_field).permit(:name, :usage, :form_field_id)
  end
end
