class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :patient
      t.string :location
      t.datetime :start
      t.datetime :end
      t.references :user_holder, foreign_key: true

      t.timestamps
    end
  end
end
