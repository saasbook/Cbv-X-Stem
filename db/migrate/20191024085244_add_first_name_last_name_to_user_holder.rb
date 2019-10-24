class AddFirstNameLastNameToUserHolder < ActiveRecord::Migration[5.2]
  def change
    add_column :user_holders, :first_name, :string
    add_column :user_holders, :last_name, :string
  end
end
