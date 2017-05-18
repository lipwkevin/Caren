class AddPreferenceToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :preference, :string , :default => "Daily"
  end
end
