class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.integer :day
      t.time :time
      t.string :name
      t.string :category
      t.text :remark
      t.references :schedule, foreign_key: true

      t.timestamps
    end
  end
end
