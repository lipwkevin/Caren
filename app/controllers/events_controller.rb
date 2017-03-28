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
      unless current_user.provider.nil? && current_user.token.nil?
        Event.save_to_google(current_user.token,[{date:@event.date,
        time:@event.time,
        remarks:@event.remarks,
        name:@event.name}])
      end
      # redirect_to calendar_show_path, notice: 'Event Added'
      flash[:notice]= 'Event Added'
      render "form_completed.js.erb"
    else
      @target = "new-modal"
      render "form_fail.js.erb"
    end
  end

  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    if @event.update params.require(:event).permit([:name,:date,:time,:category,:remarks])
      flash[:notice] = 'Calendar updated'
      render "form_completed.js.erb"
    else
      @target = "edit-modal"
      render "form_fail.js.erb"
    end
  end

  def destroy
    @event = Event.find params[:id]
    if @event.user==current_user
      @event.destroy
      flash.now[:alert]  = 'task deleted!'
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
    if(current_user.provider && current_user.token)
      Event.save_to_google(current_user.token,event_list)
    end
    redirect_to calendar_show_path, notice: 'Schedule Added'
  end

  def check_event
    event = Event.find params[:id]
    event.toggle!(:completed)
    render :json => {completed:event.completed,id:event.id}
  end
end
