class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_activities, :string, :description
  end
end
