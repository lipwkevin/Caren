class WelcomeController < ApplicationController
  def home
    if user_signed_in?
      @events = current_user.get_schedule(Date.today)
    end
  end

  def about
  end
end
