class AddDetailsToUserSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :user_settings, :name, :string
    add_column :user_settings, :email_notification, :boolean
    add_column :user_settings, :whatsapp_notification, :boolean
  end
end
