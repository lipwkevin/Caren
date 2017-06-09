class CalendarController < ApplicationController

  before_action :authenticate_user

  def show
    session[:calendar] = current_user.preference unless session[:calendar]
    case session[:calendar]
    when "Daily"
      redirect_to calendar_show_path
    when "3-Days"
      redirect_to calendar_3days_show_path
    when "Weekly"
      redirect_to calendar_week_show_path
    when "Monthly"
      redirect_to calendar_month_show_path
    else
      redirect_to root_path, alert:'Invalid action'
    end
  end

  def calendar
    cookies[:date] = params[:date] unless (params[:date].nil? || params[:date]=="")
    session[:calendar] = "Daily"
    @date = Date.strptime(cookies[:date],"%m/%d/%Y")
    @events = current_user.get_schedule_with_filter(@date,session[:filters])
    @diaries = current_user.get_Diaries(@date)
    @event = Event.new
  end

  def calendar_week
    cookies[:date] = params[:date] unless (params[:date].nil? || params[:date]=="")
    session[:calendar] = "Weekly"
    @date = Date.strptime(cookies[:date],"%m/%d/%Y")
    @weekStart = @date.at_beginning_of_week
    @weekEnd = @date.at_end_of_week
    @events = {}
    @events[:priority] = Hash.new{|hash, key| hash[key] = {}}
    @events[:regular] = Hash.new{|hash, key| hash[key] = {}}
    @results = current_user.get_schedule_with_range(@weekStart,@weekEnd,session[:filters])
    @results.each do |result|
      if result.priority?
        @events[:priority][result.name][:category]= result.category
        @events[:priority][result.name][result.date.strftime("%A")] = {completed:result.completed,id:result.id}
      else
        @events[:regular][result.name][:category]= result.category
        @events[:regular][result.name][result.date.strftime("%A")] = {completed:result.completed,id:result.id}
      end
    end
  end

  def calendar_month
    session[:calendar] = "Monthly"
    @date = Date.strptime(cookies[:date],"%m/%d/%Y")
    startDate = @date.beginning_of_month.beginning_of_week
    endDate = @date.end_of_month.end_of_week
    @date_range = []
    (startDate..endDate).map{|date| @date_range.push({
      date: date,
      active: (date.month == @date.month),
      events: current_user.get_schedule_with_filter(date,session[:filters])
    })}
    # events =

  end

  def calendar_3days
    cookies[:date] = params[:date] unless (params[:date].nil? || params[:date]=="")
    session[:calendar] = "3-Days"
    @date = Date.strptime(cookies[:date],"%m/%d/%Y")
    @yesterday = {events:current_user.get_schedule_with_filter(@date.yesterday,session[:filters]),
                 date:@date.yesterday.strftime("%A, %B %d, %Y")}
    @today = {events:current_user.get_schedule_with_filter(@date,session[:filters]),
                 date:@date.strftime("%A, %B %d, %Y")}
    @tomorrow = {events:current_user.get_schedule_with_filter(@date.tomorrow,session[:filters]),
                 date:@date.tomorrow.strftime("%A, %B %d, %Y")}
  end

  def filter
    session[:filters] = params[:filters]
    redirect_to calendar_path
  end
end
