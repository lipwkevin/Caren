class Event < ApplicationRecord
  belongs_to :user

  def self.addEvent(day,offset,time,name,category,remarks,user)
    Event.create({
      date:day+offset.to_i,
      time:time,
      name:name,
      category:category,
      remarks:remarks,
      user:user
      })
      return({
        date:day+offset.to_i,
        time:time,
        remarks:remarks,
        name:name
        })
  end


  def self.save_to_google(token,events)
    unless(token.nil?)
      client = Signet::OAuth2::Client.new({
        client_id: ENV["GOOGLE_CLIENT_ID"],
        client_secret:  ENV["GOOGLE_CLIENT_SECRET"],
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        refresh_token: token
      })
      client.fetch_access_token!
      calendar = Google::Apis::CalendarV3::CalendarService.new
      calendar.authorization = client
    end
    events.each do |event|

      gevent = Google::Apis::CalendarV3::Event.new({
        'summary': event[:name],
        'description': event[:remarks],
        'start':{
          'date_time': combine_datetime(event[:date],event[:time]),
        },
        'end':{
          'date_time': combine_datetime(event[:date],event[:time])+1.hour,
        },
      })
      calendar.insert_event('primary', gevent)
    end
  end

  def get_color
    t = time.hour
    if (MORNING_START..NOON_START).cover? t
      return "morning"
    elsif (NOON_START..NIGHT_START).cover? t
      return "noon"
    else
      return 'night'
    end
  end

  def get_strike
    return (completed)? "strikeout" : ""
  end


  def self.combine_datetime(date,time)
    datetime = date.to_datetime.change(hour:time.hour,min:time.min,sec:time.sec,offset:time.strftime("%Z"))
  end
end
