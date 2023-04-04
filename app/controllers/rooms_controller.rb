# frozen_string_literal: true

class RoomsController < ApplicationController
  load_and_authorize_resource
  before_action :set_room, only: %i[]

  # GET /rooms or /rooms.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @rooms.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @rooms = pagy(@search.result, items: per_page)
  end

  # GET /rooms/1 or /rooms/1.json
  def show; end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit; end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    attach_account_for(@room)

    respond_to do |format|
      if @room.save
        format.html { redirect_to rooms_url, notice: 'Room has been successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        process_errors(@room)
        format.html { redirect_to rooms_url }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to rooms_url, notice: 'Room has been successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:capacity, :name, :color)
  end
end
