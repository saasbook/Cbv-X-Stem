class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :sender_name
      t.string :sender_email
      t.string :receiver_email
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
