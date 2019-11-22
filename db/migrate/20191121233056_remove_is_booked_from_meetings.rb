class RemoveIsBookedFromMeetings < ActiveRecord::Migration[5.2]
  def change
    remove_column :meetings, :is_booked, :boolean
  end
end
