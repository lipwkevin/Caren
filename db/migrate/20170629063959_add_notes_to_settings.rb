class AddNotesToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :notes, :text
  end
end
