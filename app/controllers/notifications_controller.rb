# frozen_string_literal: true

class NotificationsController < ApplicationController
  load_and_authorize_resource

  def read
    @notification.send(params[:operation])
  end

  def update
    respond_to do |format|
      if @account_type.update(notifications_params)
        format.html { redirect_to account_types_url, notice: 'Account type was successfully updated.' }
        format.json { render :show, status: :ok, location: @account_type }
      else
        format.html { redirect_to account_types_url }
        format.json { render json: @account_type.errors }
      end
    end
  end

  private

  def notifications_params
    params.require(:notification).permit
  end
end
