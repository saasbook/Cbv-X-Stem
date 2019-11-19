class AddFieldToUserActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :user_activities, :field, :string
  end
end
