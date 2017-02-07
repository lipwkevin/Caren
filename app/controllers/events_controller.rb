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

  def destroy
    event = Event.find params[:id]
    if event.user==current_user
      event.destroy
      redirect_to calendar_show_path, notice: 'Event deleted!' ,status: 303
    else
      redirect_to root_path, alert: 'access denied'
    end
  end

  def run_schedule
    Event.create({
      date:Date.today+1,
      time:Time.now,
      name:'testing',
      category:'what'
      })
  end
end
