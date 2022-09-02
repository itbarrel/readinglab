class MeetingstudentsController < ApplicationController
  before_action :set_meetingstudent, only: %i[ show edit update destroy ]

  # GET /meetingstudents or /meetingstudents.json
  def index
    @meetingstudents = Meetingstudent.all
  end

  # GET /meetingstudents/1 or /meetingstudents/1.json
  def show
  end

  # GET /meetingstudents/new
  def new
    @meetingstudent = Meetingstudent.new
  end

  # GET /meetingstudents/1/edit
  def edit
  end

  # POST /meetingstudents or /meetingstudents.json
  def create
    @meetingstudent = Meetingstudent.new(meetingstudent_params)

    respond_to do |format|
      if @meetingstudent.save
        format.html { redirect_to meetingstudent_url(@meetingstudent), notice: "Meetingstudent was successfully created." }
        format.json { render :show, status: :created, location: @meetingstudent }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meetingstudent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetingstudents/1 or /meetingstudents/1.json
  def update
    respond_to do |format|
      if @meetingstudent.update(meetingstudent_params)
        format.html { redirect_to meetingstudent_url(@meetingstudent), notice: "Meetingstudent was successfully updated." }
        format.json { render :show, status: :ok, location: @meetingstudent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meetingstudent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetingstudents/1 or /meetingstudents/1.json
  def destroy
    @meetingstudent.destroy

    respond_to do |format|
      format.html { redirect_to meetingstudents_url, notice: "Meetingstudent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meetingstudent
      @meetingstudent = Meetingstudent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meetingstudent_params
      params.require(:meetingstudent).permit(:attended, :deleted_at, :active, :account_id, :meeting_id, :user_id)
    end
end
