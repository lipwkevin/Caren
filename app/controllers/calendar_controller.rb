class CalendarController < ApplicationController

  before_action :authenticate_user

  def enter_calendar
    cookies[:date] = Date.today
  end

  def calendar
    cookies[:date] = params[:date] unless (params[:date].nil? || params[:date]=="")
    @date = cookies[:date]
    @events = current_user.get_schedule_with_filter(@date,cookies[:filters].split("&"))
    @event = Event.new
  end

  def filter
    cookies[:filters] = params[:filters]
    redirect_to calendar_show_path
  end
end
