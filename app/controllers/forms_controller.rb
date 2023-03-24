# frozen_string_literal: true

class FormsController < ApplicationController
  load_and_authorize_resource
  before_action :set_form, only: %i[]

  # GET /forms or /forms.json
  def index
    @forms = Form.all
  end

  def show; end

  # GET /forms/new
  def new
    @form = Form.new
    @form.form_fields.build
  end

  # GET /forms/1/edit
  def edit; end

  # POST /forms or /forms.json
  def create
    @form = Form.new(form_params)
    attach_account_for(@form)

    respond_to do |format|
      if @form.save
        format.html { redirect_to form_url(@form), notice: 'Form was successfully created.' }
        format.json { render :show, status: :created, location: @form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forms/1 or /forms/1.json
  def update
    respond_to do |format|
      if @form.update(form_params)
        format.html { redirect_to form_url(@form), notice: 'Form was successfully updated.' }
        format.json { render :show, status: :ok, location: @form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forms/1 or /forms/1.json
  def destroy
    @form.destroy

    respond_to do |format|
      format.html { redirect_to forms_url, notice: 'Form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = Form.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def form_params
    params.require(:form).permit(:name, :purpose,
                                 form_fields_attributes:
                                  %i[id name description sort_order field_type data_type necessary])
  end
end
