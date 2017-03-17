class AddTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :token, :string
    add_column :users, :calendar_email, :string
  end
end
