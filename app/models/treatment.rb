class Treatment < ApplicationRecord
  # Name and the Descrption of the treatment are required when creating entry.
  validates_presence_of :name, :description

  # Many to One Relationship :: Each UserHolder owns Many Treatments.
  belongs_to :user_holder
end
