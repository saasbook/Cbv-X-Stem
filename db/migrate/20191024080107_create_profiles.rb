class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      # t.references :user_holder, foreign_key: true
      t.integer :user_holder_id
      # t.timestamps
    end
  end
end
