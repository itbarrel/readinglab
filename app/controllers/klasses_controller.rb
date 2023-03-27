# frozen_string_literal: true

class KlassesController < ApplicationController
  load_and_authorize_resource
  before_action :set_klass, only: %i[extend_sessions]

  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    if params[:classes_at].present?
      @klasses_for_date = true
      @klasses = @klasses.at(params[:classes_at])
    end

    # if params[:start].present?
    #   start_date = params[:start]
    #   @interviews = @interviews.where(
    #     '(date)::date > ?', start_date.to_date
    #   )
    # end

    # if params[:end].present?
    #   end_date = params[:end]
    #   @interviews = @interviews.where(
    #     '(date)::date < ?', end_date.to_date
    #   )
    # end

    @search = @klasses.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @klasses = pagy(@search.result, items: per_page)
  end

  def show; end

  def new
    start_date = params[:start_date] ? params[:start_date].to_date : Time.zone.today + 8.hours
    @klass = Klass.new(starts_at: start_date)
    check_availability_for(start_date)
  end

  def availability
    start_date = params[:start_date] ? params[:start_date].to_date : Time.zone.today
    check_availability_for(start_date)
  end

  def edit; end

  # POST /klasses or /klasses.json
  def create
    @klass = Klass.new(klass_params)
    attach_account_for(@klass)

    respond_to do |format|
      if @klass.save
        format.html { redirect_to klass_url, notice: 'Klass was successfully created.' }
        format.json { render :show, status: :created, location: @klass }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @klass.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # PATCH/PUT /klasses/1 or /klasses/1.json
  def update
    respond_to do |format|
      if @klass.update(klass_params)
        format.html { redirect_to klass_url(@klass), notice: 'Klass was successfully updated.' }
        format.json { render :show, status: :ok, location: @klass }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @klass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /klasses/1 or /klasses/1.json
  def destroy
    @klass.destroy

    respond_to do |format|
      format.html { redirect_to klasses_url, notice: 'Klass was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def extend_sessions
    session_count = params[:session_count].to_i || 0
    @klass.extend_meetings(session_count, @klass.starts_at)
    flash[:notice] = "#{session_count} Meetings have been extended successfully."
  end

  private

  def check_availability_for(start_date)
    @filtered_teachers = Teacher.available_at(start_date)
    @filtered_rooms = Room.available_at(start_date)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_klass
    @klass = Klass.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def klass_params
    params.require(:klass).permit(:max_students, :starts_at, :monday, :tuesday, :wednesday, :thursday, :friday,
                                  :saturday, :sunday, :session_range, :duration,
                                  :est_end_date, :min_students, :name, :description,
                                  :teacher_id, :room_id, :klass_template_id, :attendance_form_id, form_ids: [])
  end
end
