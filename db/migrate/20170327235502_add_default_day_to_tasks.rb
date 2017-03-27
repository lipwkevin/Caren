class AddDefaultDayToTasks < ActiveRecord::Migration[5.0]
  def change
    change_column :tasks, :day, :integer, :default => 0
  end
end
