class Schedule < ApplicationRecord
  belongs_to :user

  has_many :tasks, dependent: :destroy

  validates :duration, presence: true,:numericality => { :greater_than => 0 }
  # non-negative

  def generate_tasks(name,time,category,remark,important)
    (1..duration).each do |day|
      task = Task.new
      task.name = name
      task.time = time
      task.category = category
      task.day = day
      task.priority = important
      task.remark = remark
      task.schedule_id = self.id
      return false unless task.save
    end
    return true
  end
end
