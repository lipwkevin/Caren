class CalendarController < ApplicationController

  before_action :authenticate_user

  def show
    case current_user.preference
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
  def enter_calendar
    cookies[:date] = Date.today
  end

  def calendar
    cookies[:date] = params[:date] unless (params[:date].nil? || params[:date]=="")
    cookies[:date] = Date.today if (cookies[:date].nil?)
    cookies[:filters] = Category.pluck(:name) if cookies[:filters].nil?
    @date = Date.strptime(cookies[:date],"%m/%d/%Y")
    @events = current_user.get_schedule_with_filter(@date,cookies[:filters].split("&"))
    @diaries = current_user.get_Diaries(@date)
    @event = Event.new
  end

  def calendar_week
    cookies[:date] = params[:date] unless (params[:date].nil? || params[:date]=="")
    cookies[:date] = Date.today if (cookies[:date].nil?)
    @date = Date.strptime(cookies[:date],"%m/%d/%Y")
    @weekStart = @date.at_beginning_of_week
    @weekEnd = @date.at_end_of_week
    @events = {}
    @events[:priority] = Hash.new{|hash, key| hash[key] = {}}
    @events[:regular] = Hash.new{|hash, key| hash[key] = {}}
    @results = current_user.get_week_schedule(@weekStart,@weekEnd)
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

  end

  def calendar_3days
    cookies[:date] = params[:date] unless (params[:date].nil? || params[:date]=="")
    cookies[:date] = Date.today if (cookies[:date].nil?)
    @date = Date.strptime(cookies[:date],"%m/%d/%Y")
  end

  def filter
    cookies[:filters] = params[:filters]
    redirect_to calendar_show_path
  end
end
