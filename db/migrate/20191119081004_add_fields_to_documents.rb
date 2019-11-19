class AddFieldsToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :documents_info, :text
    add_column :documents, :documents_status, :string
    add_column :documents, :documents_name, :string
    add_column :documents, :documents_explanation, :text
  end
end
