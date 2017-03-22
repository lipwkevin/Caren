class TasksController < ApplicationController

  before_action :authenticate_user

  def create
    if params[:task][:day]!="Everyday"
      task_params = params.require(:task).permit(:name,:day,:time,:category,:remark)
      @schedule = current_user.schedules.first
      @task = Task.new task_params
      @task.schedule = @schedule
      if @task.save
        redirect_to schedule_show_path, notice: 'Task Added'
      else
        flash[:alert] = "Error"
        render 'schedules/show'
      end
    else
      if current_user.generate_tasks(params[:task][:name],params[:task][:time],params[:task][:category],params[:task][:remark])
        redirect_to schedule_show_path, notice: 'Tasks Added'
      else
        flash[:alert] = "Error"
        redirect_to schedule_show_path, alert: 'Failed to add every day tasks'
      end
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
