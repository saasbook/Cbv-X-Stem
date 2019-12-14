class Treatment < ApplicationRecord
  belongs_to :user_holder

  validates :provider, presence: true, length: { minimum: 3, maximum: 20 }
  validates :status, presence: true, length: { minimum: 2, maximum: 20 }
  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true



end
