class AddUserToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :user_holder, foreign_key: true
  end
end
