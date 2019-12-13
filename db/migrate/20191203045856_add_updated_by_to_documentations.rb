class AddUpdatedByToDocumentations < ActiveRecord::Migration[5.2]
  def change
    add_column :documentations, :updated_by, :string
  end
end
