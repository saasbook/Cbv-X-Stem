class AddFieldsToDocumentations < ActiveRecord::Migration[5.2]
  def change
    add_column :documentations, :documents_info, :text
    add_column :documentations, :documents_status, :string
    add_column :documentations, :documents_name, :string
    add_column :documentations, :documents_explanation, :text
  end
end
