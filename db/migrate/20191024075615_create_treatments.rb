class CreateTreatments < ActiveRecord::Migration[5.2]
  def change
    create_table :treatments do |t|
      t.string :name
      t.string :description
      t.references :user_holder, foreign_key: true

      t.timestamps
    end
  end
end
