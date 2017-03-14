class TasksController < ApplicationController

  before_action :authenticate_user

  def create
    task_params = params.require(:task).permit(:name,:day,:time,:category,:remark)
    @schedule = current_user.schedules.first
    @task = Task.new task_params
    @task.schedule = @schedule
    if @task.save
      redirect_to schedule_path, notice: 'Task Added'
    else
      render 'schedules/show'
    end
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    if @task.update params.require(:task).permit([:name,:day,:time,:category,:remark])
      redirect_to schedule_show_path, notice: 'Schedule updated'
    else
      flash.now[:alert] = 'Please see errors below!'
      # render :edit
    end
  end
  def destroy
    task = Task.find params[:id]
      task.destroy
      redirect_to schedule_show_path, notice: 'task deleted!' ,status: 303
  end
end
