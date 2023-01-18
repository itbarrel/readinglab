# frozen_string_literal: true

class KlassTempelateFormsController < ApplicationController
  load_and_authorize_resource
  before_action :set_klass_tempelate_form, only: %i[]

  # GET /klass_tempelate_forms or /klass_tempelate_forms.json
  def index
    @klass_tempelate_forms = KlassTempelateForm.all
  end

  # GET /klass_tempelate_forms/1 or /klass_tempelate_forms/1.json
  def show; end

  # GET /klass_tempelate_forms/new
  def new
    @klass_tempelate_form = KlassTempelateForm.new
  end

  # GET /klass_tempelate_forms/1/edit
  def edit; end

  # POST /klass_tempelate_forms or /klass_tempelate_forms.json
  def create
    @klass_tempelate_form = KlassTempelateForm.new(klass_tempelate_form_params)

    respond_to do |format|
      if @klass_tempelate_form.save
        format.html do
          redirect_to klass_tempelate_form_url(@klass_tempelate_form),
                      notice: 'Klass tempelate form was successfully created.'
        end
        format.json { render :show, status: :created, location: @klass_tempelate_form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @klass_tempelate_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /klass_tempelate_forms/1 or /klass_tempelate_forms/1.json
  def update
    respond_to do |format|
      if @klass_tempelate_form.update(klass_tempelate_form_params)
        format.html do
          redirect_to klass_tempelate_form_url(@klass_tempelate_form),
                      notice: 'Klass tempelate form was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @klass_tempelate_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @klass_tempelate_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /klass_tempelate_forms/1 or /klass_tempelate_forms/1.json
  def destroy
    @klass_tempelate_form.destroy

    respond_to do |format|
      format.html { redirect_to klass_tempelate_forms_url, notice: 'Klass tempelate form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_klass_tempelate_form
    @klass_tempelate_form = KlassTempelateForm.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def klass_tempelate_form_params
    params.require(:klass_tempelate_form).permit(:klass_tempelate_id, :form_id)
  end
end
