# frozen_string_literal: true

class ParentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_parent, only: %i[]

  # GET /parents or /parents.json
  def index
    # @parents = Parent.all
    @search = @parents.ransack(params[:q])
    @search.sorts = 'father_first asc' if @search.sorts.empty?
    @pagy, @parents = pagy(@search.result.includes(:account, :city),
                           items: params[:per_page] || '10')
    # @pagy, @parents = pagy(Parent.all, items: params[:per_page] || '10')
  end

  # GET /parents/1 or /parents/1.json
  def show; end

  # GET /parents/new
  def new
    @parent = Parent.new
  end

  # GET /parents/1/edit
  def edit; end

  # POST /parents or /parents.json
  def create
    @parent = Parent.new(parent_params)
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_parent
    @parent = Parent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def parent_params
    params.require(:parent).permit(:father_first, :father_last, :father_email, :father_phone, :mother_first,
                                   :mother_last, :mother_email, :mother_phone, :address,
                                   :state, :postal_code, :city_id)
  end
end
