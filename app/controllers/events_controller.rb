# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show]

  def show; end

  private

  def set_event
    @event = Meeting.find_by(id: params[:id])
    @event = Interview.find_by(id: params[:id]) if @event.blank?
  end

  def email_params
    params.permit(:title, :message)
  end
end
