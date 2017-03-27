class UsersController < ApplicationController

  before_action :authenticate_user,except:[:new,:create]

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
    current_user.destroy
    session[:user_id] = nil
    redirect_to root_path, alert: "Account deleted",status:303
  end

  def edit
    @user = current_user
  end

  def update
    user_params = params.require(:user).permit([:first_name,:last_name, :email])
    @user = current_user
    if @user.update user_params
      flash.now[:notice]='Account updated!'
      render "/layouts/display_flash.js.erb"
    else
      flash.now[:alert] = 'Please see errors below!'
      render :update_failed
    end
  end

  def update_password
    # byebug
    if params[:user][:password_new] != params[:user][:password_new_confirmation]
      flash.now[:alert]='Password and password confirm does not match'
    elsif current_user.authenticate(params[:user][:password_old])
      current_user.update(password:params[:user][:password_new],password_confirmation:params[:user][:password_new_confirmation])
      flash.now[:notice]='Password Updated!'
    else
      flash.now[:alert]='Wrong Password!'
    end
    render "/layouts/display_flash.js.erb"
  end

  def reset_password

  end

  def reset_password_respond
    # byebug
    token = Token.find_by(key:params[:key])
    user = User.find(token.target)
    if user.email == params[:user][:email]
      user.update(password:params[:user][:password_new],password_confirmation:params[:user][:password_new_confirmation])
      token.destroy
    else
      render "reset_password_fail"
    end
  end
end
