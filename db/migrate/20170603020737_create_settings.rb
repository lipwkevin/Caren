class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.references :user, foreign_key: true
      t.integer :duration, default: 7
      t.string :doctor
      t.string :infusion_center
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :province
      t.string :address_line_2
      t.string :postal
      
      t.timestamps
    end
  end
end
