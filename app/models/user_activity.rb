class UserActivity < ApplicationRecord
  belongs_to :user_holder

  # Actor, Action, Category, and Original_val are required when creating entry.
  validates :actor, presence: true, length: { minimum: 3, maximum: 30 }
  validates :action, presence: true, length: { minimum: 3, maximum: 30 }
  validates :category, presence: true, length: { minimum: 3, maximum: 30 }
  validates :original_val, presence: true


  def user_activity_params
    params.permit(:actor, :action, :category, :original_val, :new_val)
  end

  # === === === === ===
  # Helper function
  # === === === === ===

  # NOTICE All access to Relationship Database should be through UserHolder Relationship,
  # - this function is recommended when accessing UserActivity database.

  # Access Point for UserActivity database
  # - Browse through all list of UserActivity through UserHolder.
  # - Augments UserHolder fields.


end
