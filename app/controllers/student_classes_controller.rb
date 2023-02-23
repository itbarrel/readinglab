# frozen_string_literal: true

class StudentClassesController < ApplicationController
  load_and_authorize_resource
  before_action :set_student_class, only: %i[]

  # GET /student_classes or /student_classes.json
  def index
    @student_classes = StudentClass.all
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
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student_class.errors, status: :unprocessable_entity }
      end
      format.js { render 'shared/flash' }
    end
  end

  # PATCH/PUT /student_classes/1 or /student_classes/1.json
  def update
    respond_to do |format|
      if @student_class.update(student_class_params)
        format.html do
          redirect_to student_class_url(@student_class), notice: 'Student class has been successfully updated.'
        end
        format.json { render :show, status: :ok, location: @student_class }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student_class.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student_class.destroy
    flash[:notice] = 'Student has been removed from class successfully.'

    respond_to do |format|
      format.html { redirect_to student_classes_url, notice: 'Student class has been successfully destroyed.' }
      format.json { head :no_content }
      format.js { render 'shared/flash' }
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
