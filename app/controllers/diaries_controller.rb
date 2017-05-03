class DiariesController < ApplicationController
  def create
    diary_params = params[:content]
    date = cookies[:date]
    diary = Diary.new
    diary.content = diary_params
    diary.user = current_user
    diary.day = date
    if diary.save
     redirect_to calendar_show_path, notice: 'Diary added'
    else
      render "form"
    end
  end

  def destroy
  end
end
