class AddUploadedByToDocumentations < ActiveRecord::Migration[5.2]
  def change
    add_column :documentations, :uploaded_by, :string
  end
end
