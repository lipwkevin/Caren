class Diary < ApplicationRecord

  validates :day, presence: true
  validates :content, presence: true

  belongs_to :user
end
