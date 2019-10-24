class UserHolder < ApplicationRecord
  # Email, First Name, and Last Name is required when creating entry.
  validates_presence_of :email, :first_name, :last_name

  # One to One Relationship :: One UserHolder to One Profile.
  has_one :profile

  # One to One Relationship :: One UserHolder to One UserSetting.
  has_one :user_setting

  # One to Many Relationship :: One UserHolder to Many Documents.
  has_many :documents
  accepts_nested_attributes_for :documents,
                              reject_if: lambda { |attrs| attrs['name'].blank? || attrs['url'].blank? }

  # One to Many Relationship :: One UserHolder to Many Treatments
  has_many :treatments
  accepts_nested_attributes_for :treatments,
                              reject_if: lambda { |attrs| attrs['name'].blank? || attrs['description'].blank? }
end
