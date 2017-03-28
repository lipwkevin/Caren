require 'google/apis/calendar_v3'

class CallbacksController < ApplicationController
  before_action :authenticate_user

  def google

    # if current_user.provider.nil? || current_user.token.nil?
      auth = request.env["omniauth.auth"]
      # need this token to work with google services
      # token = auth["credentials"]["token"]
      refresh_token = auth["credentials"]["refresh_token"]
      # expires_at = auth["credentials"]["expires_at"]
      gmail = auth["info"]["email"]
      # current_user.update(provider:auth[:provider],
                            # token:refresh_token,
                            # calendar_email:gmail)
    # end
    render :json => auth.to_json
    # redirect_to user_show_path
  end

  # def redirect
  #   client = Signet::OAuth2::Client.new({
  #     client_id: ENV["GOOGLE_CLIENT_ID"],
  #     client_secret:  ENV["GOOGLE_CLIENT_SECRET"],
  #     token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
  #     refresh_token: current_user.token
  #   })
  #   client.fetch_access_token!
  #   calendar = Google::Apis::CalendarV3::CalendarService.new
  #   calendar.authorization = client
  #
  #   redirect_to root_path
  # end

  def failure
    redirect_to user_show_path, alert:"Error"
  end

end
