class AddDefaultToTables < ActiveRecord::Migration[5.0]
  def change
    change_column :tasks, :time, :time, :default => "00:00".to_time
    change_column :events, :time, :time, :default => "00:00".to_time
    change_column :users, :first_name, :string, :default => "Anonymous"
    change_column :users, :last_name, :string, :default => "User"
    change_column :schedules, :duration, :integer, :default => 7
  end
end
