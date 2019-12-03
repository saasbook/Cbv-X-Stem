class AddNameToMedication < ActiveRecord::Migration[5.2]
  def change
    add_column :medications, :name, :string
  end
end
