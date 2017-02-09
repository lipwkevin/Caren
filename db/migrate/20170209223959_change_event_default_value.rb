class ChangeEventDefaultValue < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :completed, :boolean, :default => false
  end
end
