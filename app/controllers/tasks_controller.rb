class TasksController < ApplicationController

  before_action :authenticate_user
  
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

  def destroy
    task = Task.find params[:id]
      task.destroy
      redirect_to schedule_show_path, notice: 'task deleted!' ,status: 303
  end
end
