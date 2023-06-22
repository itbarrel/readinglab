# frozen_string_literal: true

class StaffsController < ApplicationController
  load_and_authorize_resource :staff, class: User
  before_action :set_staff, only: %i[show update password]
  before_action :set_staffs, only: %i[trash]

  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @staffs.ransack(params[:q])
    @search.sorts = 'first_name asc' if @search.sorts.empty?
    @pagy, @staffs = pagy(@search.result, items: per_page)
  end

  # GET /staffs/1 or /staffs/1.json
  def show; end

  # GET /staffs/new
  def new; end

  def password; end

  # GET /staffs/1/edit
  def edit; end

  # POST /staffs or /staffs.json
  def create
    @staff = current_account.users.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to request.referer, notice: 'Staff has been successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        process_errors(@staff)
        format.html { redirect_to staffs_url }
        format.json { render json: @staff.errors }
      end
    end
  end

  # PATCH/PUT /staffs/1 or /staffs/1.json
  def update
    respond_to do |format|
      if @staff.update(staff_params)
        format.html { redirect_to request.referer, notice: 'Staff has been successfully updated.' }
        format.json { render :index, status: :ok, location: @staff }
      else
        format.html { redirect_to staffs_url }
        format.json { render json: @staff.errors }
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

  def trash
    @staffs.destroy_all
    flash[:notice] = 'staffs has been successfully Deleted.'
    render js: "window.location = '#{staffs_url}'"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_staff
    @staff = current_account.users.find(params[:id])
  end

  def set_staffs
    @staffs = current_account.users.where(id: params[:ids])
  end

  # Only allow a list of trusted parameters through.
  def staff_params
    params.require(:staff).permit(:first_name, :last_name, :email, :postal_code, :phone, :role, :profile, :password,
                                  :account_id)
  end
end
