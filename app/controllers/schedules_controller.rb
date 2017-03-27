class SchedulesController < ApplicationController
  before_action :authenticate_user
  def show
    @schedule = current_user.schedules.first
    @task = Task.new
  end

  def update
    @completed=false;
    @schedule = current_user.schedules.first
    if @schedule.update params.require(:schedule).permit([:duration])
      flash.now[:notice] = "Duration Updated"
      @completed=true;
    else
      flash.now[:alert] =  @schedule.errors.full_messages.join("<br>")
    end
  end
end
