class Task < ApplicationRecord
   attr_accessor :everyday
  belongs_to :schedule

  validates :name, presence: true, length: { minimum: 3 }
  validates :day, presence: true
  validates :time, presence: true
  validates :category, presence: true

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

  def get_category
    return self.category
  end
end
