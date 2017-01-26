class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.boolean :completed
      t.time :time
      t.date :date
      t.string :name
      t.string :category
      t.references :user, foreign_key: true
      t.text :remarks

      t.timestamps
    end
  end
end
