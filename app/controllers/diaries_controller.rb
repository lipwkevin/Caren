class DiariesController < ApplicationController

  before_action :authenticate_user

  def create
    diary_params = params[:content]
    date = params[:date]
    diary = Diary.new
    diary.content = diary_params
    diary.user = current_user
    diary.day = Date.strptime(date,"%m/%d/%Y")
    if params[:content].empty? || params[:content].nil?
      redirect_to calendar_show_path, alert: 'Diary Cannot Be Empty'
      return
    elsif diary.save
     redirect_to calendar_show_path, notice: 'Diary added'
     return
    else
      redirect_to calendar_show_path, alert: 'Unexpected Error'
      return
    end
  end

  def destroy
    @diary = Diary.find params[:id]
    @diary.destroy
    flash.now[:alert]  = 'task deleted!'
  end
end
