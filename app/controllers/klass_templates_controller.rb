# frozen_string_literal: true

class KlassTemplatesController < ApplicationController
  before_action :set_klass_template, only: %i[show edit update destroy]

  # GET /klass_templates or /klass_templates.json
  def index
    @klass_templates = KlassTemplate.all
  end

  # GET /klass_templates/1 or /klass_templates/1.json
  def show; end

  # GET /klass_templates/new
  def new
    @klass_template = KlassTemplate.new
  end

  # GET /klass_templates/1/edit
  def edit; end

  # POST /klass_templates or /klass_templates.json
  def create
    @klass_template = KlassTemplate.new(klass_template_params)

    respond_to do |format|
      if @klass_template.save
        format.html do
          redirect_to klass_template_url(@klass_template), notice: 'Klass template was successfully created.'
        end
        format.json { render :show, status: :created, location: @klass_template }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @klass_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /klass_templates/1 or /klass_templates/1.json
  def update
    respond_to do |format|
      if @klass_template.update(klass_template_params)
        format.html do
          redirect_to klass_template_url(@klass_template), notice: 'Klass template was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @klass_template }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @klass_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /klass_templates/1 or /klass_templates/1.json
  def destroy
    @klass_template.destroy

    respond_to do |format|
      format.html { redirect_to klass_templates_url, notice: 'Klass template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_klass_template
    @klass_template = KlassTemplate.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def klass_template_params
    params.require(:klass_template).permit(:max_students, :active, :start, :monday, :tuesday, :wednesday, :thursday,
                                           :friday, :saturday, :sunday, :settings, :session_range,
                                           :duration, :min_students, :name, :description, :deleted_at,
                                           :account_id, :user_id, :room_id)
  end
end
