class CalendarController < ApplicationController

  before_action :authenticate_user

  def enter_calendar
    cookies[:date] = Date.today
  end

  def calendar
    cookies[:date] = params[:date] unless (params[:date].nil? || params[:date]=="")
    cookies[:date] = Date.today # if (cookies[:date].nil?)
    cookies[:filters] = Category.pluck(:name) if cookies[:filters].nil?
    @date = cookies[:date]
    @events = current_user.get_schedule_with_filter(@date,cookies[:filters].split("&"))
    @diaries = current_user.get_Diaries(@date)
    @event = Event.new
  end

  def calendar_week

  end

  def filter
    cookies[:filters] = params[:filters]
    redirect_to calendar_show_path
  end
end
