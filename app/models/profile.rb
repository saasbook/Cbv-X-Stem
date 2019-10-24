class Profile < ApplicationRecord
  # First Name, Last Name, and Email are required when creating entry.
  validates_presense_of :first_name, :last_name, :email

  # One to One Relationship :: Each UserHolder owns One Profile.
  belongs_to :user_holder
end
