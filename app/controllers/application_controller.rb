class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def authenticate_user
    redirect_to root_path, alert:'Please Log-in and try again' unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    (@current_user ||= User.find(session[:user_id]) ) if user_signed_in?
  end
  helper_method :current_user

  def viewing_date
    (@viewing_date ||= Date.today.to_s)
  end
  helper_method :viewing_date

end
