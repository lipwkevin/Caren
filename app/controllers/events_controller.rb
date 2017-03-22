class EventsController < ApplicationController

  before_action :authenticate_user

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

  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    if @event.update params.require(:event).permit([:name,:date,:time,:category,:remarks])
      flash[:notice] = 'Calendar updated'
      redirect_to calendar_show_path
    else
      flash.now[:alert] = 'Please see errors below!'
      render :edit
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
    events = current_user.schedules.first.tasks
    date = cookies[:date].to_date
    event_list = [];
    events.each do |event|
      event_list.push(Event.addEvent(date,event.day,event.time,event.name,event.category,event.remark,current_user))
    end
    redirect_to calendar_show_path, notice: 'Schedule Added'
  end

  def check_event
    event = Event.find params[:id]
    event.toggle!(:completed)
    render :json => {completed:event.completed,id:event.id}
  end
end
