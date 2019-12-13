class AddSatisfiedToDocumentations < ActiveRecord::Migration[5.2]
  def change
    add_column :documentations, :satisfied, :boolean
  end
end
