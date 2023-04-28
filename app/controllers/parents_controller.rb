# frozen_string_literal: true

class ParentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_parent, only: %i[]
  before_action :set_parents, only: %i[trash]

  # GET /parents or /parents.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @parents.ransack(params[:q])
    @search.sorts = 'father_first asc' if @search.sorts.empty?
    @pagy, @parents = pagy(@search.result.includes(:city), items: per_page)
  end

  # GET /parents/1 or /parents/1.json
  def show; end

  # GET /parents/new
  def new
    @parent = current_account.parents.new
  end

  # GET /parents/1/edit
  def edit; end

  # POST /parents or /parents.json
  def create
    @parent = current_account.parents.new(parent_params)
    attach_account_for(@parent)

    respond_to do |format|
      if @parent.save
        format.html { redirect_to parents_url, notice: 'Parents has been successfully created.' }
        format.json { render :index, status: :created, location: @parent }
      else
        process_errors(@parent)
        format.html { redirect_to parents_url, status: :unprocessable_entity }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parents/1 or /parents/1.json
  def update
    respond_to do |format|
      if @parent.update(parent_params)
        format.html { redirect_to parents_url, notice: 'Parents has been successfully updated.' }
        format.json { render :index, status: :ok, location: @parent }
      else
        format.html { redirect_to parents_url, status: :unprocessable_entity }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parents/1 or /parents/1.json
  def destroy
    @parent.destroy

    respond_to do |format|
      format.html { redirect_to parents_url, notice: 'Parents has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def trash
    @parents.destroy_all
    flash[:notice] = 'parents has been successfully Deleted.'
    render js: "window.location = '#{parents_url}'"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_parent
    @parent = current_account.parents.find(params[:id])
  end

  def set_parents
    @parents = current_account.parents.where(id: params[:ids])
  end

  # Only allow a list of trusted parameters through.
  def parent_params
    params.require(:parent).permit(:father_first, :father_last, :father_email, :father_phone, :mother_first,
                                   :mother_last, :mother_email, :mother_phone, :address,
                                   :state, :postal_code, :city_id)
  end
end
