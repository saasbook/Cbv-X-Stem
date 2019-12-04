class AddReasoningToDocumentations < ActiveRecord::Migration[5.2]
  def change
    add_column :documentations, :reasoning, :string
  end
end
