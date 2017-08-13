class RemoveDoctorFromSettings < ActiveRecord::Migration[5.0]
  def change
    remove_column :settings, :doctor
    remove_column :settings, :infusion_center
  end
end
