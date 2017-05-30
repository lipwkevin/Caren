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
      removeOutOfBoundTask()
      flash[:notice] = "Duration Updated"
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    else
      flash.now[:alert] =  @schedule.errors.full_messages.join("<br>")
    end
  end

  def clear
    schedule = current_user.schedules.first
    schedule.tasks.destroy_all
    flash[:alert] = "Schedule Cleared"
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end
  private
  def removeOutOfBoundTask
    tasks = @schedule.tasks
    tasks.each do |task|
      if(task.day > @schedule.duration)
        task.destroy
      end
    end
  end
end
