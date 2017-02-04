class CalendarController < ApplicationController

  def calendar
    @events = Event.all
    # User.getEvent(date)
  end
end
