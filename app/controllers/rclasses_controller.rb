class RclassesController < ApplicationController
  before_action :set_rclass, only: %i[ show edit update destroy ]

  # GET /rclasses or /rclasses.json
  def index
    @rclasses = Rclass.all
  end

  # GET /rclasses/1 or /rclasses/1.json
  def show
  end

  # GET /rclasses/new
  def new
    @rclass = Rclass.new
  end

  # GET /rclasses/1/edit
  def edit
  end

  # POST /rclasses or /rclasses.json
  def create
    @rclass = Rclass.new(rclass_params)

    respond_to do |format|
      if @rclass.save
        format.html { redirect_to rclass_url(@rclass), notice: "Rclass was successfully created." }
        format.json { render :show, status: :created, location: @rclass }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rclasses/1 or /rclasses/1.json
  def update
    respond_to do |format|
      if @rclass.update(rclass_params)
        format.html { redirect_to rclass_url(@rclass), notice: "Rclass was successfully updated." }
        format.json { render :show, status: :ok, location: @rclass }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rclasses/1 or /rclasses/1.json
  def destroy
    @rclass.destroy

    respond_to do |format|
      format.html { redirect_to rclasses_url, notice: "Rclass was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rclass
      @rclass = Rclass.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rclass_params
      params.require(:rclass).permit(:max_students, :active, :start, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :session_range, :duration, :est_end_date, :min_students, :name, :description, :deleted_at, :account_id, :user_id, :room_id)
    end
end
