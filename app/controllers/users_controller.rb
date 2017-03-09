class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit([:uid,:first_name,:last_name, :email,:password,:password_confirmation])
    @user = User.new user_params
    if @user.save
      # create a new schedule
      # to-do
      Schedule.create(user:@user)
     session[:user_id] = @user.id
     redirect_to root_path, notice: 'Thankyou for signing up'
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def destroy
  end

  def edit
    @user = current_user
  end

  def update
    user_params = params.require(:user).permit([:first_name,:last_name, :email])
    @user = current_user
    if @user.update user_params
      redirect_to(:user_show)
    else
      flash.now[:alert] = 'Please see errors below!'
      render :edit
    end
  end

  def edit_password
    render :file => '/users/password.js.erb'
  end

  def update_password
    if current_user.authenticate(params[:user][:password_old])
      current_user.update(password:params[:user][:password_new],password_confirmation:params[:user][:password_new_confirmation])
      redirect_to :user_show, notice: 'Password Changed'
    else
      redirect_to :user_show, alert:'Wrong Password'
    end
  end

  def reset_password
    current_user.update(password:params[:user][:password_new],password_confirmation:params[:user][:password_new_confirmation])
    redirect_to :root, notice: 'Password Reset'
  end
end
