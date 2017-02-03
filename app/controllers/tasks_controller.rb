class TasksController < ApplicationController
  def create
    task_params = params.require(:task).permit(:name,:day,:time,:category,:remark)
    @schedule = Schedule.find params[:schedule_id]
    @task = Task.new task_params
    @task.schedule = @schedule
    if @task.save
      redirect_to :back, notice: 'Task Added'
    else
      render 'schedules/show'
    end
  end
end
