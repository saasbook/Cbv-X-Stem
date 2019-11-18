class AddIsDoctorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_doctor, :boolean
  end
end
