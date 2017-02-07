class CalendarController < ApplicationController

  def calendar
    @date = (params[:date].nil? ? Date.today.to_s : params[:date])
    @events = current_user.events.where(date:@date.to_date)
    # User.getEvent(date)
  end
end
