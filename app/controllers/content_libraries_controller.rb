class ContentLibrariesController < ApplicationController
  before_action :set_content_library, only: %i[ show edit update destroy ]

  # GET /content_libraries or /content_libraries.json
  def index
    @content_libraries = ContentLibrary.all
  end

  # GET /content_libraries/1 or /content_libraries/1.json
  def show
  end

  # GET /content_libraries/new
  def new
    @content_library = ContentLibrary.new
  end

  # GET /content_libraries/1/edit
  def edit
  end

  # POST /content_libraries or /content_libraries.json
  def create
    @content_library = ContentLibrary.new(content_library_params)

    respond_to do |format|
      if @content_library.save
        format.html { redirect_to content_library_url(@content_library), notice: "Content library was successfully created." }
        format.json { render :show, status: :created, location: @content_library }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @content_library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_libraries/1 or /content_libraries/1.json
  def update
    respond_to do |format|
      if @content_library.update(content_library_params)
        format.html { redirect_to content_library_url(@content_library), notice: "Content library was successfully updated." }
        format.json { render :show, status: :ok, location: @content_library }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @content_library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_libraries/1 or /content_libraries/1.json
  def destroy
    @content_library.destroy

    respond_to do |format|
      format.html { redirect_to content_libraries_url, notice: "Content library was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_library
      @content_library = ContentLibrary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def content_library_params
      params.require(:content_library).permit(:public, :title, :deleted_at, :active, :account_id)
    end
end
