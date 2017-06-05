class InfoController < ApplicationController

  before_action :authenticate_user

  def show
    @setting = current_user.settings.first
  end

  def update
    session[:return_to] ||= request.referer
    setting_param = params.require(:setting).permit([:doctor,:infusion_center, :address_line_1,:address_line_2,:city,:province,:postal])
    @setting = current_user.settings.first
    if @setting.update setting_param
      flash[:notice]='Account updated!'
      # render "/layouts/display_flash.js.erb"
      render :update_success
    else
      flash.now[:alert] = 'Please see errors below!'
      render :update_failed
    end
  end
end
