class CalendarController < ApplicationController

  def enter_calendar
    cookies[:date] = Date.today
  end

  def calendar
    cookies[:date] = params[:date] unless params[:date].nil?
    @date = cookies[:date]
    @events = current_user.get_schedule(@date)
    # @events = current_user.events.where(date:Date.strptime(@date, '%d/%m/%Y'))
    # User.getEvent(date)
  end
end
