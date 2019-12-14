class UserSetting < ApplicationRecord
  # One to One Relationship :: Each UserHolder owns One User Setting.
  belongs_to :user_holder
  has_one :email_notif
  has_one :whatsapp_notif
  has_one :website_notif
end
