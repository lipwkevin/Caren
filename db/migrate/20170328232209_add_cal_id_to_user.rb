class AddCalIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :calID, :string
  end
end
