class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies[:filters] = Category.pluck(:name)
      redirect_to root_path, notice: 'Welcome'
    elsif user.nil?
      flash.now[:alert] = 'User not found'
      render :new
    else
      flash.now[:alert] = 'Fail to log in, please try again'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    # equivalent to deleting the user_id key from session
    redirect_to root_path, notice: 'Goodbye'
  end

end
