# frozen_string_literal: true

class FormDetailsController < ApplicationController
  load_and_authorize_resource
  before_action :set_form_detail, only: %i[]

  # GET /form_details or /form_details.json
  def index
    @form_details = FormDetail.all
  end

  # GET /form_details/1 or /form_details/1.json
  def show; end

  # GET /form_details/new
  def new
    @form_detail = FormDetail.new
  end

  # GET /form_details/1/edit
  def edit; end

  # POST /form_details or /form_details.json
  def create
    @form_detail = FormDetail.new(form_detail_params)

    respond_to do |format|
      if @form_detail.save
        format.html { redirect_to form_detail_url(@form_detail), notice: 'Form detail was successfully created.' }
        format.json { render :show, status: :created, location: @form_detail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @form_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /form_details/1 or /form_details/1.json
  def update
    respond_to do |format|
      if @form_detail.update(form_detail_params)
        format.html { redirect_to form_detail_url(@form_detail), notice: 'Form detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @form_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @form_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form_details/1 or /form_details/1.json
  def destroy
    @form_detail.destroy

    respond_to do |format|
      format.html { redirect_to form_details_url, notice: 'Form detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_form_detail
    @form_detail = FormDetail.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def form_detail_params
    params.require(:form_detail).permit(:form_values, :parent_types, :user_id, :form_id,
                                        :parent_id)
  end
end
