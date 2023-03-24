# frozen_string_literal: true

class StaffsController < ApplicationController
  load_and_authorize_resource :staff, class: User
  before_action :set_staff, only: %i[]

  # GET /staffs or /staffs.json
  def index
    # @staffs = Staff.all
    @search = @staffs.ransack(params[:q])
    @search.sorts = 'first_name asc' if @search.sorts.empty?
    @pagy, @staffs = pagy(@search.result,
                          items: params[:per_page] || '10')
  end

  # GET /staffs/1 or /staffs/1.json
  def show; end

  # GET /staffs/new
  def new; end

  # GET /staffs/1/edit
  def edit; end

  # POST /staffs or /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to staff_url, notice: 'Staff has been successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1 or /staffs/1.json
  def update
    respond_to do |format|
      if @staff.update(staff_params)
        format.html { redirect_to request.referer, notice: 'Staff has been successfully updated.' }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1 or /staffs/1.json
  def destroy
    @staff.destroy

    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_staff
    @staff = Staff.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def staff_params
    params.require(:staff).permit(:first_name, :last_name, :email, :postal_code, :phone, :emergency_name,
                                  :emergency_contact, :date_of_hire, :date_of_inactive, :setting,
                                  :undeletable, :external_user, :termination_date, :role)
  end
end
