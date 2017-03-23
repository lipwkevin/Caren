class Token < ApplicationRecord
  validates :key, presence: true, uniqueness: { case_sensitive: false }
  validates :event, presence: true
  validates :target, presence: true
end
