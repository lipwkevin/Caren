class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_email
  # before_validation :downcase_uid

  has_many :schedules, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :diaries, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :uid, presence: true,
                    uniqueness: { case_sensitive: false,
                                  message: 'must be unique' },
                    length: { minimum: 3 }

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  validates :password, confirmation: true,
                       length: { minimum: 6 },
                       on: :create
  validates :password, confirmation: true,
                       length: { minimum: 6 },
                       on: :update, if: :password_digest_changed?

  validates :first_name, presence: true

  # validates :terms_of_service, acceptance: true, message: 'must be check T&A'



  def name
    return "#{first_name} #{last_name}"
  end

  def get_schedule(date)
    return events.where(date:date.to_date).order(priority: :desc,time: :desc)
  end

  def get_schedule_with_filter(date,filters)
    return events.where("category IN (?)",filters).where(date:date.to_date).order(priority: :desc,time: :asc)
  end

  def get_week_schedule(startDate,endDate)
    return events.where(:date => startDate..endDate).order(:priority)
  end
  def get_Diaries(date)
    return diaries.where(day:date.to_date)
  end
  def get_duration
    ["Everyday"]+(0..(schedules.first.duration)).to_a
  end

  def generate_tasks(name,time,category,remark,priority)
    return schedules.first.generate_tasks(name,time,category,remark,priority)
  end

  private

  def downcase_email
    self.email.downcase! if email.present?
  end


  def downcase_uid
    self.uid.downcase! if uid.present?
  end

end
