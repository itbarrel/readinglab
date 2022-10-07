# frozen_string_literal: true

class KlassFormsController < ApplicationController
  before_action :set_klass_form, only: %i[show edit update destroy]

  # GET /klass_forms or /klass_forms.json
  def index
    @klass_forms = KlassForm.all
  end

  # GET /klass_forms/1 or /klass_forms/1.json
  def show; end

  # GET /klass_forms/new
  def new
    @klass_form = KlassForm.new
  end

  # GET /klass_forms/1/edit
  def edit; end

  # POST /klass_forms or /klass_forms.json
  def create
    @klass_form = KlassForm.new(klass_form_params)

    respond_to do |format|
      if @klass_form.save
        format.html { redirect_to klass_form_url(@klass_form), notice: 'Klass form was successfully created.' }
        format.json { render :show, status: :created, location: @klass_form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @klass_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /klass_forms/1 or /klass_forms/1.json
  def update
    respond_to do |format|
      if @klass_form.update(klass_form_params)
        format.html { redirect_to klass_form_url(@klass_form), notice: 'Klass form was successfully updated.' }
        format.json { render :show, status: :ok, location: @klass_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @klass_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /klass_forms/1 or /klass_forms/1.json
  def destroy
    @klass_form.destroy

    respond_to do |format|
      format.html { redirect_to klass_forms_url, notice: 'Klass form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_klass_form
    @klass_form = KlassForm.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def klass_form_params
    params.require(:klass_form).permit(:deleted_at, :form_id, :klass_id)
  end
end
