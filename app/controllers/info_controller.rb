class InfoController < ApplicationController

  before_action :authenticate_user

  def show
    @settings = current_user.settings
  end

  def create
    setting_params = params.require(:setting).permit(   :duration,
                                                        :doctor,
                                                        :phone,
                                                        :fax,
                                                        :email,
                                                        :provider,
                                                        :infusion_center,
                                                        :address_line_1,
                                                        :address_line_2,
                                                        :city,
                                                        :notes,
                                                        :province,
                                                        :postal)
    @setting = Setting.new setting_params
    @setting.user = current_user
    if @setting.save
      flash[:notice]= 'Infomation Added'
      render "update_success.js.erb"
    else
      @target = "new-modal"
      render "update_failed.js.erb"
    end
  end

  def edit
    @setting = Setting.find params[:id]
    render "edit.js.erb"
  end

  def update
    session[:return_to] ||= request.referer
    @setting = Setting.find params[:id]
    setting_param = params.require(:setting).permit([:duration,
                                                      :doctor,
                                                      :phone,
                                                      :fax,
                                                      :email,
                                                      :provider,
                                                      :infusion_center,
                                                      :address_line_1,
                                                      :address_line_2,
                                                      :city,
                                                      :province,
                                                      :notes,
                                                      :postal])
    if @setting.update setting_param
      flash[:notice]='Account updated!'
      render :update_success
    else
      flash.now[:alert] = 'Please see errors below!'
      render :update_failed
    end
  end

  def destroy
    @setting = Setting.find params[:id]
    if @setting.user==current_user
      @setting.destroy
      flash.now[:alert]  = 'info deleted!'
      render "delete_success.js.erb"
    else
      flash.now[:alert]  = 'access deninded!'
      render "layouts/display_flash.js.erb"
    end
  end
end
