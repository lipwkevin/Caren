class SchedulesController < ApplicationController
  before_action :authenticate_user
  def show
    @schedule = current_user.schedules.first
    # byebug
    @task = Task.new
  end
end
