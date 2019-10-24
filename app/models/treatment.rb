class Treatment < ApplicationRecord
  # Name and the Descrption of the treatment are required when creating entry.
  validates_presence_of :name, :description

  # Many to One Relationship :: Each UserHolder owns Many Treatments.
  belongs_to :user_holder

  # === === === === ===
  # Helper function
  # === === === === ===

  # NOTICE All access to Relationship Database should be through UserHolder Relationship,
  # - this function is recommended when accessing Treatments database.

  # Access all Treatments for that User
  # - Input: user_holder_id for UserHolder
  # - Output: List of all ActiveRecord of Treatments of that user.
  def all_treatments_by_user_holder_id(user_holder_id)
    UserHolder.find_by_id(user_holder_id).treatments
  end
end
