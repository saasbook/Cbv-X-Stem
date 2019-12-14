class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user_holder, foreign_key: true
      
      t.boolean :create_doc, :default => true
      t.boolean :change_doc_status, :default => true
      t.boolean :require_doc_change, :default => true

      t.timestamps
    end
  end
end
