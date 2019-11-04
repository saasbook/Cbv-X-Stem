class AddUserToUserHolder < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_holders, :user, foreign_key: true
  end
end
