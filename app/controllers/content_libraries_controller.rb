# frozen_string_literal: true

class ContentLibrariesController < ApplicationController
  load_and_authorize_resource
  before_action :set_content_library, only: %i[]

  # GET /content_libraries or /content_libraries.json
  def index
    @content_libraries = current_account.content_libraries
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @content_libraries.ransack(params[:q])
    @search.sorts = 'title asc' if @search.sorts.empty?
    @pagy, @content_libraries = pagy(@search.result, items: per_page)
  end

  # GET /content_libraries/1 or /content_libraries/1.json
  def show; end

  # GET /content_libraries/new
  def new
    @content_library = current_account.content_libraries.new
  end

  # GET /content_libraries/1/edit
  def edit; end

  # POST /content_libraries or /content_libraries.json
  def create
    @content_library = current_account.content_libraries.new(content_library_params)

    respond_to do |format|
      if @content_library.save
        format.html do
          redirect_to content_libraries_url, notice: 'Content library was successfully created.'
        end
        format.json { render :show, status: :created, location: @content_library }
      else
        format.html { redirect_to content_libraries_url }
        format.json { render json: @content_library.errors }
      end
    end
  end

  # PATCH/PUT /content_libraries/1 or /content_libraries/1.json
  def update
    respond_to do |format|
      if @content_library.update(content_library_params)
        format.html do
          redirect_to content_libraries_url, notice: 'Content library was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @content_library }
      else
        format.html { redirect_to content_libraries_url }
        format.json { render json: @content_library.errors }
      end
    end
  end

  # DELETE /content_libraries/1 or /content_libraries/1.json
  def destroy
    @content_library.destroy

    respond_to do |format|
      format.html { redirect_to content_libraries_url, notice: 'Content library was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_content_library
    @content_library = current_account.content_libraries.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def content_library_params
    params.require(:content_library).permit(:public, :title)
  end
end
