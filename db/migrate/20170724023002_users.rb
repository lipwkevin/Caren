class Users < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :preference_weekly, :string , :default => "Calendar"
  end
end
