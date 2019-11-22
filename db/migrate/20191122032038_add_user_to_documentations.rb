class AddUserToDocumentations < ActiveRecord::Migration[5.2]
  def change
    add_reference :documentations, :user_holder, foreign_key: true
  end
end
