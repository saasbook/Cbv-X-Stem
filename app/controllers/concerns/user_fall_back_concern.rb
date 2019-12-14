module UserFallBackConcern
  extend ActiveSupport::Concern

  # Overrides the current_user
  def current_user
    super || guest_user
  end

  # Default User as Guest
  def guest_user
    User.find_by_email('guest@guest.com')
  end

end
