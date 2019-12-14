class AddEndTimeToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :end_time, :datetime
  end
end
