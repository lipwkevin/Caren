class User < ApplicationRecord
  has_secure_password

  has_many :schedules, dependent: :destroy
  has_many :events, dependent: :destroy

  def name
    return "#{first_name} #{last_name}"
  end

  def get_schedule(date)
    return events.where(date:date.to_date).order(:time)
  end
end
