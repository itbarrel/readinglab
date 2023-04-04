# frozen_string_literal: true

class KlassTemplatesController < ApplicationController
  load_and_authorize_resource
  before_action :set_klass_template, only: %i[]

  # GET /klass_templates or /klass_templates.json
  def index
    # @klass_templates = KlassTemplate.all
    @search = @klass_templates.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @klass_templates = pagy(@search.result.includes(:teacher, :room),
                                   items: params[:per_page] || '10')
  end

  def show; end

  def new
    @klass_template = KlassTemplate.new
  end

  def edit; end

  def create
    @klass_template = KlassTemplate.new(klass_template_params)
    attach_account_for(@klass_template)

    respond_to do |format|
      if @klass_template.save
        format.html { redirect_to klass_templates_url, notice: 'Class Template has been successfully created.' }
        format.json { render :show, status: :created, location: @klass_template }
      else
        process_errors(@klass_template)
        format.html { redirect_to klass_templates_url }
        format.json { render json: @klass_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @klass_template.update(klass_template_params)
        format.html { redirect_to klass_templates_url, notice: 'Class Template has been successfully updated.' }
        format.json { render :show, status: :ok, location: @klass_template }
      else
        process_errors(@klass_template)
        format.html { redirect_to klass_templates_url }
        format.json { render json: @klass_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /klass_templates/1 or /klass_templates/1.json
  def destroy
    @klass_template.destroy

    respond_to do |format|
      format.html { redirect_to klass_templates_url, notice: 'Class template has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_klass_template
    @klass_template = KlassTemplate.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def klass_template_params
    params.require(:klass_template).permit(:name, :max_students, :start, :monday, :tuesday, :wednesday, :thursday,
                                           :friday, :saturday, :sunday, :settings, :session_range,
                                           :duration, :description,
                                           :teacher_id, :room_id)
  end
end
