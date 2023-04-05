# frozen_string_literal: true

class MessageTemplatesController < ApplicationController
  load_and_authorize_resource
  before_action :set_message_template, only: %i[show edit update destroy]

  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @message_templates.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @message_templates = pagy(@search.result, items: per_page)
  end

  def show; end

  def new
    @message_template = current_account.messagetemplates.new
  end

  def edit; end

  def create
    @message_template = current_account.messagetemplates.new(message_template_params)
    attach_account_for(@message_template)

    respond_to do |format|
      if @message_template.save
        format.html { redirect_to message_templates_url, notice: 'Message Template has been successfully created.' }
        format.json { render :show, status: :created, location: @message_template }
      else
        process_errors(@message_template)
        format.html { redirect_to message_templates_url }
        format.json { render json: @message_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message_template.update(message_template_params)
        format.html { redirect_to message_templates_url, notice: 'Message Template has been successfully updated.' }
        format.json { render :show, status: :ok, location: @message_template }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @message_template.errors, status: :unprocessable_entity }
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

  def assign; end

  private

  def set_message_template
    @message_template = current_account.messagetemplates.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_template_params
    params.require(:message_template).permit(:name, :description)
  end
end
