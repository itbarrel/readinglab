# frozen_string_literal: true

class MessageTemplatesController < ApplicationController
  load_and_authorize_resource
  before_action :set_message_template, only: %i[show edit update destroy]
  before_action :set_message_templates, only: %i[trash]

  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @message_templates.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @message_templates = pagy(@search.result, items: per_page)
  end

  def show; end

  def new
    @message_template = current_account.message_templates.new
  end

  def edit; end

  def create
    @message_template = current_account.message_templates.new(message_template_params)
    respond_to do |format|
      if @message_template.save
        format.html { redirect_to message_templates_url, notice: 'Message Template has been successfully created.' }
        format.json { render :show, status: :created, location: @message_template }
      else
        process_errors(@message_template)
        format.html { redirect_to message_templates_url }
        format.json { render json: @message_template.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @message_template.update(message_template_params)
        format.html { redirect_to message_templates_url, notice: 'Message Template has been successfully updated.' }
        format.json { render :show, status: :ok, location: @message_template }
      else
        format.html { redirect_to message_templates_url }
        format.json { render json: @message_template.errors }
      end
    end
  end

  def destroy
    @message_template.destroy

    respond_to do |format|
      format.html { redirect_to message_templates_url, notice: 'Message Template has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def trash
    @message_templates.destroy_all
    flash[:notice] = 'message_templates has been successfully Deleted.'
    render js: "window.location = '#{message_templates_url}'"
  end

  def assign; end

  private

  def set_message_template
    @message_template = current_account.message_templates.find(params[:id])
  end

  def set_message_templates
    @message_templates = current_account.message_templates.where(id: params[:ids])
  end

  # Only allow a list of trusted parameters through.
  def message_template_params
    params.require(:message_template).permit(:name, :description)
  end
end
