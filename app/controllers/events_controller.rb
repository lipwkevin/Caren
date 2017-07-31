class EventsController < ApplicationController

  before_action :authenticate_user

  def new
    @event = Event.new
  end

  def create
    event_params = params.require(:event).permit(:name,:time,:category,:remarks,:priority)
    @event = Event.new event_params
    @event.date = (Date.strptime(params[:event][:date],"%m/%d/%Y"))
    if (params["repeat"] == "One Time Event")
      @event.user = current_user
      if @event.save
        unless current_user.provider.nil? || current_user.token.nil?
          Event.save_to_google(current_user.token,[{date:@event.date,
          time:@event.time,
          remarks:@event.remarks,
          name:@event.name}],current_user.calID)
        end
        # redirect_to calendar_show_path, notice: 'Event Added'
        flash[:notice]= 'Event Added'
        render "form_completed.js.erb"
      else
        @target = "new-modal"
        render "form_fail.js.erb"
      end
    else
      quantity = params["quantity"];
      repeat_option = params["repeat"]
      case repeat_option
      when "Daily"
        puts "Daily"
      when "Weekly"
        puts "Weekly"
      when "Monthly"
        puts "Monthly"
      else
        @target = "new-modal"
        render "form_fail.js.erb"
      end
    end
  end

  def repeatCreateEvent(event_params,date,offsetSelector,quantity)
    offset = nil
    case offsetSelector
    when "Daily"
      offset = quantity.days
    when "Weekly"
      offset = quantity.weeks
    when "Monthly"
      offset = quantity.months
    end
    
  end
  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    @event.update(date:(Date.strptime(params[:event][:date],"%m/%d/%Y")))
    if @event.update params.require(:event).permit([:name,:time,:category,:remarks,:priority])
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
    date = Date.strptime(cookies[:date],"%m/%d/%Y")
    event_list = [];
    events.each do |event|
      event_list.push(Event.addEvent(date,event.day,event.time,event.name,event.category,event.remark,current_user,event.priority))
    end
    unless (current_user.provider.nil? || current_user.token.nil?)
      Event.save_to_google(current_user.token,event_list,current_user.calID)
    end
    redirect_to calendar_show_path, notice: 'Schedule Added'
  end

  def check_event
    event = Event.find params[:id]
    event.toggle!(:completed)
    render :json => {completed:event.completed,id:event.id}
  end
end
