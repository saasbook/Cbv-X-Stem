class Meetingsandusers < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :meetings, :user_holders
  end
end
