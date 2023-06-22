# frozen_string_literal: true

class KlassFormsController < ApplicationController
  load_and_authorize_resource
  before_action :set_klass_form, only: %i[]

  # GET /klass_forms or /klass_forms.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @klass_forms.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @klass_forms = pagy(@search.result, items: per_page)
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
        format.html { redirect_to klass_forms_url, notice: 'Klass form was successfully created.' }
        format.json { render :show, status: :created, location: @klass_form }
      else
        format.html { redirect_to klass_forms_url }
        format.json { render json: @klass_form.errors }
      end
    end
  end

  # PATCH/PUT /klass_forms/1 or /klass_forms/1.json
  def update
    respond_to do |format|
      if @klass_form.update(klass_form_params)
        format.html { redirect_to klass_forms_url, notice: 'Klass form was successfully updated.' }
        format.json { render :show, status: :ok, location: @klass_form }
      else
        format.html { redirect_to klass_forms_url }
        format.json { render json: @klass_form.errors }
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
    params.require(:klass_form).permit(:form_id, :klass_id)
  end
end
