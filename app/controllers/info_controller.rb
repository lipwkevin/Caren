class InfoController < ApplicationController

  before_action :authenticate_user

  def show
    @setting = current_user.settings.first
    # vvvvv this should be removed on final version
    if @setting.nil?
      @setting = Setting.create(user:current_user)
    end
    # ^^^^^ this should be removed on final version
  end

  def update
    session[:return_to] ||= request.referer
    setting_param = params.require(:setting).permit([:doctor,:infusion_center, :address_line_1,:address_line_2,:city,:province,:postal])
    @setting = current_user.settings.first
    if @setting.update setting_param
      flash[:notice]='Account updated!'
      render :update_success
    else
      flash.now[:alert] = 'Please see errors below!'
      render :update_failed
    end
  end
end
