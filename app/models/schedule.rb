class Schedule < ApplicationRecord
  belongs_to :user

  has_many :tasks, dependent: :destroy

  validates :duration, presence: true

  def generate_tasks(name,time,category,remark)
    (1..duration).each do |day|
      task = Task.new
      task.name = name
      task.time = time
      task.category = category
      task.day = day
      task.remark = remark
      task.schedule_id = self.id
      return false unless task.save
    end
    return true
  end
end
