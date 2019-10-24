class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :url
      t.references :user_holder, foreign_key: true

      t.timestamps
    end
  end
end
