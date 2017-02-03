class AddDurationToSchedules < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :duration, :integer
  end
end
