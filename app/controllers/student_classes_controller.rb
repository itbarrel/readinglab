# frozen_string_literal: true

class StudentClassesController < ApplicationController
  load_and_authorize_resource
  before_action :set_student_class, only: %i[]

  # GET /student_classes or /student_classes.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @student_classes.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @student_classes = pagy(@search.result, items: per_page)
  end

  # GET /student_classes/1 or /student_classes/1.json
  def show; end

  # GET /student_classes/new
  def new
    @student_class = StudentClass.new
  end

  # GET /student_classes/1/edit
  def edit; end

  # POST /student_classes or /student_classes.json
  def create
    @student_class = StudentClass.new(student_class_params)

    respond_to do |format|
      if @student_class.save
        flash[:notice] = 'Student was successfully Added.'
        format.html { redirect_to request.referer, notice: 'Student has been successfully created.' }
        format.json { render :show, status: :created, location: @student_class }
      else
        process_errors(@student_class)
        format.html { redirect_to request.referer }
        format.json { render json: @student_class.errors }
      end
      format.js
    end
  end

  # PATCH/PUT /student_classes/1 or /student_classes/1.json
  def update
    respond_to do |format|
      if @student_class.update(student_class_params)
        format.html do
          redirect_to student_classes_url, notice: 'Student class has been successfully updated.'
        end
        format.json { render :show, status: :ok, location: @student_class }
      else
        format.html { redirect_to student_classes_url }
        format.json { render json: @student_class.errors }
      end
    end
  end

  def destroy
    @student_class.destroy
    flash[:notice] = 'Student has been removed from class successfully.'

    respond_to do |format|
      format.html { redirect_to student_classes_url, notice: 'Student class has been successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student_class
    @student_class = StudentClass.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_class_params
    params.require(:student_class).permit(:student_id, :klass_id)
  end
end
