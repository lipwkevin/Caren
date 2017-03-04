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
end
