# frozen_string_literal: true

class GradesController < ApplicationController
  load_and_authorize_resource
  before_action :set_grade, only: %i[destroy update edit]

  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @grades.ransack(params[:q])
    @search.sorts = 'title asc' if @search.sorts.empty?
    @pagy, @grades = pagy(@search.result, items: per_page)
  end

  def show; end

  def new; end

  def edit; end

  def create
    @grade = Grade.new(grade_params)

    respond_to do |format|
      if @grade.save
        format.html { redirect_to request.referer, notice: 'Grade has been successfully created.' }
        format.json { render :show, status: :created, location: @grade }
      else
        process_errors(@grade)
        format.html { redirect_to request.referer }
        format.json { render json: @grade.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to request.referer, notice: 'Grade has been successfully updated.' }
        format.json { render :index, status: :ok, location: @grade }
      else
        format.html { redirect_to request.referer }
        format.json { render json: @grade.errors }
      end
    end
  end

  def destroy
    @grade.destroy

    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Grade has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_grade
    @grade = Grade.find(params[:id])
  end

  def grade_params
    params.require(:grade).permit(:title)
  end
end
