require 'google/apis/calendar_v3'

class CallbacksController < ApplicationController
  before_action :authenticate_user

  def google

    if current_user.provider.nil?
      auth = request.env["omniauth.auth"]
      # need this token to work with google services
      # token = auth["credentials"]["token"]
      refresh_token = auth["credentials"]["refresh_token"]
      # expires_at = auth["credentials"]["expires_at"]
      gmail = auth["info"]["email"]
      current_user.update(provider:auth[:provider],token:refresh_token,calendar_email:gmail)
    end

    redirect_to user_show_path
  end

  def redirect
    client = Signet::OAuth2::Client.new({
      client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret:  ENV["GOOGLE_CLIENT_SECRET"],
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      refresh_token: current_user.token
    })
    client.fetch_access_token!
    calendar = Google::Apis::CalendarV3::CalendarService.new
    calendar.authorization = client

    # event = Google::Apis::CalendarV3::Event.new({
    #   'summary':'Google I/O 2015',
    #   'location':'800 Howard St., San Francisco, CA 94103',
    #   'description':'A chance to hear more about Google\'s developer products.',
    #   'start':{
    #     'date_time': DateTime.parse('2016-05-28T09:00:00-07:00'),
    #     'time_zone': 'America/Los_Angeles'
    #   },
    #   'end':{
    #     'date_time': DateTime.parse('2016-05-28T17:00:00-07:00'),
    #     'time_zone': 'America/Los_Angeles'
    #   }
    # })
    # calendar.insert_event('primary', event)
    # entry = Google::Apis::CalendarV3::CalendarListEntry.new(
    #  id: 'My Calendar Med'
    # )
    # byebug
    # calendar.insert_calendar_list(entry)
    redirect_to root_path
  end

  def failure
    redirect_to user_show_path, alert:"Error"
  end

end
