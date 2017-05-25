class DiariesController < ApplicationController
  def create
    diary_params = params[:content]
    date = params[:date]
    diary = Diary.new
    diary.content = diary_params
    diary.user = current_user
    diary.day = Date.strptime(date,"%m/%d/%Y")
    if diary.save
     redirect_to calendar_show_path, notice: 'Diary added'
    else
      render "form"
    end
  end

  def destroy
    @diary = Diary.find params[:id]
    @diary.destroy
    flash.now[:alert]  = 'task deleted!'
  end
end
