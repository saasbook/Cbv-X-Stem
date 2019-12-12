class UserHolder < ApplicationRecord
  include HasManySetupConcern

  # Email, First Name, and Last Name is required when creating entry.
  validates_presence_of :email, :first_name, :last_name

  belongs_to :user

  # One to One Relationship :: One UserHolder to One Profile.
  has_one :profile

  # One to One Relationship :: One UserHolder to One UserSetting.
  has_one :user_setting
  has_one :email_notif, :through => :user_setting
  has_one :whatsapp_notif, :through => :user_setting
  has_one :website_notif, :through => :user_setting

  has_many :meetings

  # One to Many Relationship :: One UserHolder to Many Treatments
  has_many_setup( :medications, ['directions', 'days', 'description', 'provider'])

  # One to Many Relationship :: One UserHolder to Many UserActivity.
  has_many_setup( :user_activities, ['actor', 'action', 'category', 'original_val'])

  # One to Many Relationship :: One UserHolder to Many Documents.
  has_many :documentations
  accepts_nested_attributes_for :documentations,
                              reject_if: lambda { |attrs| attrs['name'].blank? || attrs['url'].blank? }

  # One to Many Relationship :: One UserHolder to Many Treatments
  has_many_setup( :treatments, ['name', 'description', 'provider', 'status'])

  # One to Many Relationship :: One UserHolder to Many Appointmnets
  has_many :appointments
  accepts_nested_attributes_for :appointments,
                              reject_if: lambda { |attrs| attrs['patient'].blank? || attrs['location'].blank? || attrs['start'].blank? || attrs['end'].blank? }

  # One to Many Relationship :: One UserHolder to Many Messages
  has_many :messages
  accepts_nested_attributes_for :messages,
                              reject_if: lambda { |attrs| attrs['sender_name'].blank? || attrs['sender_email'].blank? || attrs['receiver_email'].blank?}

end
