class Medication < ApplicationRecord
  belongs_to :user_holder
  validates :name, presence: true
  validates :provider, presence: true, length: { minimum: 2, maximum: 20 }
  validates :directions, presence: true, length: { minimum: 2, maximum: 20 }
  validates :days, presence: true, length: { minimum: 2, maximum: 20 }

end
