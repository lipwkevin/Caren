class WelcomeController < ApplicationController
  def home
    if current_user
      date = Date.today
      startDate = date
      endDate = date+13
      @date_range = []
      (startDate..endDate).map{|date| @date_range.push({
        date: date,
        active: (date.month == date.month),
        events: current_user.get_schedule_with_filter(date,session[:filters])
      })}
    end
  end

  def about
  end
end
