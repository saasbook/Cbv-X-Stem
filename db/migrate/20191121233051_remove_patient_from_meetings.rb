class RemovePatientFromMeetings < ActiveRecord::Migration[5.2]
  def change
    remove_column :meetings, :patient, :string
  end
end
