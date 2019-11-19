class CreateMedications < ActiveRecord::Migration[5.2]
  def change
    create_table :medications do |t|
      t.string :provider
      t.string :directions
      t.string :days
      t.text :description
      t.references :user_holder, foreign_key: true

      t.timestamps
    end
  end
end
