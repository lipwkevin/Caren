class Task < ApplicationRecord
   attr_accessor :everyday
  belongs_to :schedule
end
