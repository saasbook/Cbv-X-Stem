class AddDetailsToUserSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :user_settings, :name, :string
    add_column :user_settings, :email_notification, :boolean, :default => true
    add_column :user_settings, :whatsapp_notification, :boolean, :default => true

    add_column :user_settings, :create_doc_email_notification, :string, :default => "Always notify me"
    add_column :user_settings, :create_doc_whatsapp_notification, :string, :default => "Never notify me"
    add_column :user_settings, :change_doc_email_notification, :string, :default => "Always notify me"
    add_column :user_settings, :change_doc_whatsapp_notification, :string, :default => "Never notify me"
    add_column :user_settings, :require_doc_email_notification, :string, :default => "Always notify me"
    add_column :user_settings, :require_doc_whatsapp_notification, :string, :default => "Never notify me"

    add_column :user_settings, :create_tre_email_notification, :string, :default => "Always notify me"
    add_column :user_settings, :create_tre_whatsapp_notification, :string, :default => "Never notify me"
    add_column :user_settings, :change_tre_email_notification, :string, :default => "Always notify me"
    add_column :user_settings, :change_tre_whatsapp_notification, :string, :default => "Never notify me"

    add_column :user_settings, :create_med_email_notification, :string, :default => "Always notify me"
    add_column :user_settings, :create_med_whatsapp_notification, :string, :default => "Never notify me"
    add_column :user_settings, :change_med_email_notification, :string, :default => "Always notify me"
    add_column :user_settings, :change_med_whatsapp_notification, :string, :default => "Never notify me"
  end
end
