class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.string :token
      t.string :event
      t.integer :target

      t.timestamps
    end
  end
end
