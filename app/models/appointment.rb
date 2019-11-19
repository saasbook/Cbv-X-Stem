class Appointment < ApplicationRecord
  belongs_to :user_holder
  validates :body, presence: true, uniqueness: true
end
