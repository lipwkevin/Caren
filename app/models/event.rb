class Event < ApplicationRecord
  belongs_to :user

  def self.addEvent(offset,time,name,category,remarks,user)
    Event.create({
      date:Date.today+offset.to_i,
      time:time,
      name:name,
      category:category,
      remarks:remarks,
      user:user
      })
  end
end
