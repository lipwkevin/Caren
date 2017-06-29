class AddFieldsToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :phone, :string
    add_column :settings, :fax, :string
    add_column :settings, :email, :string
    add_column :settings, :provider, :string
  end
end
