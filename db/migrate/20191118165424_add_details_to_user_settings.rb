class AddDetailsToUserSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :user_settings, :name, :string
    add_column :user_settings, :create_doc_email_notification, :string, :default => "Always notify me"
    add_column :user_settings, :create_doc_whatsapp_notification, :string, :default => "Never notify me"
    add_column :user_settings, :change_doc_email_notification, :string, :default => "Always notify me"
    add_column :user_settings, :change_doc_whatsapp_notification, :string, :default => "Never notify me"
    add_column :user_settings, :require_doc_email_notification, :string, :default => "Always notify me"
    add_column :user_settings, :require_doc_whatsapp_notification, :string, :default => "Never notify me"
  end
end
