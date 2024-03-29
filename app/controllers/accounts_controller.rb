# frozen_string_literal: true

class AccountsController < ApplicationController
  load_and_authorize_resource
  before_action :set_account, only: %i[show edit update destroy]

  # GET /accounts or /accounts.json
  def index
    per_page = false?(params[:pagination]) ? 1000 : (params[:per_page] || 10)

    @search = @accounts.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @pagy, @accounts = pagy(@search.result.includes([:account_type]), items: per_page)
  end

  # GET /accounts/1 or /accounts/1.json
  def show; end

  # GET /accounts/new
  def new
    @account = Account.new
    @account.build_admin
  end

  # GET /accounts/1/edit
  def edit; end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_url, notice: 'Account has been successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        process_errors(@account)
        format.html { redirect_to accounts_url }
        format.json { render json: @account.errors }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to request.referer, notice: 'Account has been successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { redirect_to request.referer }
        format.json { render json: @account.errors }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account has been successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def stats; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:name, :currency, :settings,
                                    :email, :address, :mobile,
                                    :timezone, :province, :postal_code, :country_code, :parent_id,
                                    :notify_emails, :billing_scheme, :account_type_id,
                                    admin_attributes: %i[first_name last_name email password])
  end
end
