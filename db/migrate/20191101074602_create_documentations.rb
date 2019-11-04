class CreateDocumentations < ActiveRecord::Migration[5.2]
  def change
    create_table :documentations do |t|
      t.string :patient
      t.string :doctype
      t.string :attachment

      t.timestamps
    end
  end
end
