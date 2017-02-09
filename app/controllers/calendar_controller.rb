class CalendarController < ApplicationController

  def enter_calendar
    cookies[:date] = Date.today
  end

  def calendar
    cookies[:date] = params[:date] unless params[:date].nil?
    @date = cookies[:date]
    @events = current_user.events.where(date:@date.to_date)
    byebug
    # User.getEvent(date)
  end
end
