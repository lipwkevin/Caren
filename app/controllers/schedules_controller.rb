class SchedulesController < ApplicationController
  def show
    @schedule = current_user.schedules.first
    @task = Task.new
  end
end
