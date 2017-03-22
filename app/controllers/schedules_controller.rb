class SchedulesController < ApplicationController
  before_action :authenticate_user
  def show
    @schedule = current_user.schedules.first
    # byebug
    @task = Task.new
  end

  def update
    schedule = current_user.schedules.first
    if schedule.update params.require(:schedule).permit([:duration])
      redirect_to schedule_show_path, notice: "Duration Updated"
    else
      redirect_to schedule_show_path, alert: "failed to update"
    end
  end
end
