class AddPatientIdToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :patient_id, :integer
  end
end
