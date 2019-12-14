class AddUserHolderIdToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :user_holder_id, :integer
  end
end
