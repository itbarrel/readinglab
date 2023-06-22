# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show update]

  def show; end

  def update
    respond_to do |format|
      if @event.update(event_params)
        flash[:notice] = 'Event has been successfully updated.'
        format.js { render 'shared/flash' }
      else
        format.json { render json: @event.errors }
      end
    end
  end

  private

  def set_event
    @event = current_account.meetings.find_by(id: params[:id])
    @event = current_account.interviews.find_by(id: params[:id]) if @event.blank?
    @event = current_account.vacations.find_by(id: params[:id]) if @event.blank?
  end

  def event_params
    pars = params.require(:event).permit(:datetime)
    event_key = @event.is_a?(Meeting) ? 'starts_at' : 'date'
    pars[event_key] = pars[:datetime]
    pars.delete(:datetime)
    pars
  end
end
