class AddColumnsToMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :is_booked, :boolean
    add_column :meetings, :patient, :string
  end
end
