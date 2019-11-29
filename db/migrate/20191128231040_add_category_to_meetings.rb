class AddCategoryToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :category, :string
  end
end
