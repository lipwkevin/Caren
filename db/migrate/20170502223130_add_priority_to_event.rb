class AddPriorityToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :priority, :boolean, :default => false
  end
end
