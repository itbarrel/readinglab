# frozen_string_literal: true

class FormsController < ApplicationController
  load_and_authorize_resource
  before_action :set_form, only: %i[]
  before_action :set_forms, only: %i[trash]

  # GET /forms or /forms.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @forms.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @forms = pagy(@search.result, items: per_page)
  end

  def show; end

  # GET /forms/new
  def new
    @form = current_account.forms.new
    # @form.form_fields.build
  end

  # GET /forms/1/edit
  def edit; end

  # POST /forms or /forms.json
  def create
    @form = current_account.forms.new(form_params)

    respond_to do |format|
      if @form.save
        format.html { redirect_to forms_url, notice: 'Form has been successfully created.' }
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
        format.html { redirect_to forms_url, notice: 'Form has been successfully updated.' }
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
      format.html { redirect_to forms_url, notice: 'Form has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def trash
    @forms.destroy_all
    flash[:notice] = 'forms has been successfully Deleted.'
    render js: "window.location = '#{forms_url}'"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = current_account.forms.find(params[:id])
  end

  def set_forms
    @forms = current_account.forms.where(id: params[:ids])
  end

  # Only allow a list of trusted parameters through.
  def form_params
    data_type_mapping = {
      number_field: 'integer'
    }
    pars = params.require(:form).permit(:name, :purpose,
                                        form_fields_attributes: [
                                          :id, :name, :description, :sort_order, :field_type, :necessary, :_destroy,
                                          { field_values_attributes: %i[id name usage _destroy] }
                                        ])

    if pars[:form_fields_attributes].present?
      pars[:form_fields_attributes].each do |_key, value|
        value['data_type'] = data_type_mapping[value['field_type'].to_sym]
      end
    end
    pars
  end
end
