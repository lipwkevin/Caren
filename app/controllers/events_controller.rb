class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    event_params = params.require(:event).permit(:name,:date,:time,:category,:remarks)
    @event = Event.new event_params
    @event.user = current_user
    if @event.save
      redirect_to calendar_show_path, notice: 'Event Added'
    else
      render 'schedules/show'
    end
  end
end
