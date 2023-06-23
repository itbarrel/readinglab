# frozen_string_literal: true

class KlassesController < ApplicationController
  load_and_authorize_resource
  before_action :set_working_klasses
  before_action :set_klass, only: %i[extend_sessions mark_obsolete]
  before_action :set_klasses, only: %i[trash]

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
    @pagy, @klasses = pagy(@search.result.includes(:room, :teacher), items: per_page)
  end

  def show; end

  def new
    start_date = params[:start_date] ? params[:start_date].to_date : Time.zone.today + 8.hours
    @klass = current_account.klasses.new(starts_at: start_date)
    check_availability_for(start_date)
  end

  def availability
    start_date = params[:start_date] ? params[:start_date].to_date : Time.zone.today
    check_availability_for(start_date)
  end

  def edit; end

  # POST /klasses or /klasses.json
  def create
    @klass = current_account.klasses.new(klass_params)

    respond_to do |format|
      if @klass.save
        flash[:notice] = 'Meeting has been added successfully.'
        format.html { redirect_to klasses_url, notice: 'Class has been successfully created.' }
        format.json { render :show, status: :created, location: @klass }
      else
        process_errors(@klass)
        format.html { redirect_to klasses_url }
        format.json { render json: @klass.errors, status: :unprocessable_entity }
      end
      format.js { render 'shared/flash' }
    end
  end

  # PATCH/PUT /klasses/1 or /klasses/1.json
  def update
    respond_to do |format|
      begin
        if @klass.update(klass_params)
          flash[:notice] = 'Class has been updated successfully.'
          format.html { redirect_to klass_url(@klass), notice: 'Class has been successfully updated.' }
          format.json { render :show, status: :ok, location: @klass }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @klass.errors, status: :unprocessable_entity }
        end
      rescue StandardError
        @klass.errors.add(:base, 'Unsccessful, Please remove data associated first.')
        process_errors(@klass)
      end
      format.js { render 'shared/flash' }
    end
  end

  # DELETE /klasses/1 or /klasses/1.json
  def destroy
    @klass.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Class has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def extend_sessions
    session_count = params[:session_count].to_i || 0
    @klass.extend_meetings(session_count, @klass.starts_at)
    flash[:notice] = "#{session_count} Meetings have been extended successfully."
  end

  def trash
    @klasses.destroy_all
    flash[:notice] = 'klasses has been successfully Deleted.'
    render js: "window.location = '#{klasses_url}'"
  end

  def obsolete
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)
    @search = @klasses.obsolete.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @klasses = pagy(@search.result.includes(:room, :teacher), items: per_page)
  end

  def mark_obsolete
    respond_to do |format|
      if @klass.update(obsolete: true)
        flash[:notice] = 'Class has been marked as obsolete'
        format.html { redirect_to request.referer, notice: 'Class has been marked as obsolete.' }
        format.json { render :show, status: :ok, location: @klass }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @klass.errors, status: :unprocessable_entity }
      end
      format.js { render 'shared/flash' }
    end
  end

  private

  def check_availability_for(start_date)
    @filtered_teachers = current_account.teachers.available_at(start_date)
    @filtered_rooms = current_account.rooms.available_at(start_date)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_klass
    @klass = current_account.klasses.find(params[:id])
  end

  def set_working_klasses
    @klasses = @klasses.working if @klasses.present?
  end

  def set_klasses
    @klasses = current_account.klasses.where(id: params[:ids])
  end

  # Only allow a list of trusted parameters through.
  def klass_params
    params.require(:klass).permit(:account_id, :max_students, :starts_at, :monday, :tuesday, :wednesday, :thursday, :friday,
                                  :saturday, :sunday, :session_range, :duration,
                                  :est_end_date, :min_students, :name, :description,
                                  :teacher_id, :room_id, :klass_template_id,
                                  :attendance_form_id,
                                  student_forms_attributes: %i[id student_class_id klass_form_id _destroy], form_ids: [])
  end
end
