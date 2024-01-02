# frozen_string_literal: true

class NotificationsController < ApplicationController
  load_and_authorize_resource

  def index
    @notifications = Notification.includes([:record]).all
  end

  def show; end

  def read
    operation_response = @notification.send(params[:operation])

    modal_invoke = !([true, false].include? operation_response)

    respond_to do |format|
      if true?(modal_invoke)
        @modal_file = operation_response[:modal_file]
        @params = operation_response[:params]
        format.js
      else
        format.js { render 'shared/flash' }
      end
    end
  end

  private

  def notifications_params
    params.require(:notification).permit
  end
end
