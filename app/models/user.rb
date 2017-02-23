class User < ApplicationRecord
  has_secure_password

  has_many :schedules, dependent: :nullify
  has_many :events, dependent: :nullify

  def name
    return "#{first_name} #{last_name}"
  end

  def get_schedule(date)
    return events.order(:time).where(date:date.to_date)
  end
end
