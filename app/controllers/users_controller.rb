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
  end

  def update
  end

  def edit_password
    render :file => '/users/password.js.erb'
  end

  def update_password
  end
end
