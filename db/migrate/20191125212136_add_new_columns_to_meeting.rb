class AddNewColumnsToMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :status, :string
    add_column :meetings, :location, :string
    add_column :meetings, :description, :string
  end
end
