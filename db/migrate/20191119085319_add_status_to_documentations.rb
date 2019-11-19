class AddStatusToDocumentations < ActiveRecord::Migration[5.2]
  def change
    add_column :documentations, :status, :string
  end
end
