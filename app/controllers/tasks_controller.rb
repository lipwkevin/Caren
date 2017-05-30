class TasksController < ApplicationController

  before_action :authenticate_user

  def create
    if params[:task][:day]!="Everyday"
      task_params = params.require(:task).permit(:name,:day,:time,:category,:remark,:priority)
      @schedule = current_user.schedules.first
      @task = Task.new task_params
      @task.schedule = @schedule
      if @task.save
        flash[:notice]= 'Schedule Created'
        render "form_completed.js.erb"
      else
        @target = "new-modal"
        render "form_fail.js.erb"
      end
    else
      if current_user.generate_tasks(params[:task][:name],params[:task][:time],params[:task][:category],params[:task][:remark],params[:task][:priority])
        # redirect_to schedule_show_path, notice: 'Tasks Added'
        flash[:notice]= 'Tasks Added'
        render "form_completed.js.erb"
      else
        # flash[:alert] = 'Failed to add every day tasks'
        # render "/layouts/display_flash.js.erb"
        @target = "new-modal"
        render "form_fail.js.erb"
      end
    end
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    if @task.update params.require(:task).permit([:name,:day,:time,:category,:remark,:priority])
      flash[:notice]= 'Schedule updated'
      render "form_completed.js.erb"
    else
      @target = "edit-modal"
      render "form_fail.js.erb"
    end
  end
  def destroy
    @task = Task.find params[:id]
    @task.destroy
    flash.now[:alert]  = 'task deleted!'
  end
end
