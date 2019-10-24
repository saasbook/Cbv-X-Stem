class CreateUserSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_settings do |t|
      t.references :user_holder, foreign_key: true

      t.timestamps
    end
  end
end
