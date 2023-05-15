# frozen_string_literal: true

class StudentFormsController < ApplicationController
  load_and_authorize_resource
  before_action :set_student_form, only: %i[]

  # GET /student_forms or /student_forms.json
  def index
    @student_forms = StudentForm.all
  end

  # GET /student_forms/1 or /student_forms/1.json
  def show; end

  # GET /student_forms/new
  def new
    @student_form = StudentForm.new
  end

  # GET /student_forms/1/edit
  def edit; end

  # POST /student_forms or /student_forms.json
  def create
    @student_form = StudentForm.new(student_form_params)

    respond_to do |format|
      if @student_form.save
        format.html { redirect_to student_forms_url, notice: 'Student form was successfully created.' }
        format.json { render :show, status: :created, location: @student_form }
      else
        format.html { redirect_to student_forms_url }
        format.json { render json: @student_form.errors }
      end
    end
  end

  # PATCH/PUT /student_forms/1 or /student_forms/1.json
  def update
    respond_to do |format|
      if @student_form.update(student_form_params)
        format.html { redirect_to student_forms_url, notice: 'Student form was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_form }
      else
        format.html { redirect_to student_forms_url }
        format.json { render json: @student_form.errors }
      end
    end
  end

  # DELETE /student_forms/1 or /student_forms/1.json
  def destroy
    @student_form.destroy

    respond_to do |format|
      format.html { redirect_to student_forms_url, notice: 'Student form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student_form
    @student_form = StudentForm.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_form_params
    params.require(:student_form).permit(:student_class_id, :klass_form_id)
  end
end
