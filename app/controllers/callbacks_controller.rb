class CallbacksController < ApplicationController
  def google
    # byebug
    redirect_to user_show_path
  end

  def redirect
    client = Signet::OAuth2::Client.new({
      client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_CLIENT_SECRET"],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: ENV["DOMAIN"]+"/auth/callback"
    })

    redirect_to client.authorization_uri.to_s
  end
end
