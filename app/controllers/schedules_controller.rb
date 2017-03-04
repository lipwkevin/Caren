class SchedulesController < ApplicationController
  def show
    @schedule = current_user.schedules.first
    # byebug
    @task = Task.new
  end
end
