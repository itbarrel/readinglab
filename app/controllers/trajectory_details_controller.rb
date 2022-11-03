# frozen_string_literal: true

class TrajectoryDetailsController < ApplicationController
  before_action :set_trajectory_detail, only: %i[show edit update destroy]

  # GET /trajectory_details or /trajectory_details.json
  def index
    @trajectory_details = TrajectoryDetail.all
  end

  # GET /trajectory_details/1 or /trajectory_details/1.json
  def show; end

  # GET /trajectory_details/new
  def new
    @trajectory_detail = TrajectoryDetail.new
  end

  # GET /trajectory_details/1/edit
  def edit; end

  # POST /trajectory_details or /trajectory_details.json
  def create
    @trajectory_detail = TrajectoryDetail.new(trajectory_detail_params)

    respond_to do |format|
      if @trajectory_detail.save
        format.html do
          redirect_to trajectory_detail_url(@trajectory_detail), notice: 'Trajectory detail was successfully created.'
        end
        format.json { render :show, status: :created, location: @trajectory_detail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trajectory_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trajectory_details/1 or /trajectory_details/1.json
  def update
    respond_to do |format|
      if @trajectory_detail.update(trajectory_detail_params)
        format.html do
          redirect_to trajectory_detail_url(@trajectory_detail), notice: 'Trajectory detail was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @trajectory_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trajectory_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trajectory_details/1 or /trajectory_details/1.json
  def destroy
    @trajectory_detail.destroy

    respond_to do |format|
      format.html { redirect_to trajectory_details_url, notice: 'Trajectory detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trajectory_detail
    @trajectory_detail = TrajectoryDetail.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trajectory_detail_params
    params.require(:trajectory_detail).permit(:error_count, :wpm, :active, :deleted_at, :grade, :season, :entry_date,
                                              :account_id, :user_id, :klass_id, :book_id)
  end
end
