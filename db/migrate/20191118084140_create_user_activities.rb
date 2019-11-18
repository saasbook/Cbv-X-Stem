class CreateUserActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_activities do |t|
      t.string :actor
      t.string :action
      t.string :category
      t.string :original_val
      t.string :new_val
      t.string :string
      t.references :user_holder, foreign_key: true

      t.timestamps
    end
  end
end
