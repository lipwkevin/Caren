class SchedulesController < ApplicationController
  before_action :authenticate_user
  def show
    @schedule = current_user.schedules.first
    @task = Task.new
  end

  def update
    @schedule = current_user.schedules.first
    if @schedule.update params.require(:schedule).permit([:duration])
      flash.now[:notice] = "Duration Updated"
    else
      flash.now[:alert] =  "failed to update"
    end
  end
end
