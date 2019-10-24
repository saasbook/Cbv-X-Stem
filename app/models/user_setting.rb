class UserSetting < ApplicationRecord
  # One to One Relationship :: Each UserHolder owns One User Setting.
  belongs_to :user_holder
end
