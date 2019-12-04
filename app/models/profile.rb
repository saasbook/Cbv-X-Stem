class Profile < ApplicationRecord
  # First Name, Last Name, and Email are required when creating entry.
  validates_presence_of :first_name, :last_name, :email

  # One to One Relationship :: Each UserHolder owns One Profile.
  belongs_to :user_holder

  # === === === === ===
  # Helper function
  # === === === === ===

  # NOTICE All access to Relationship Database should be through UserHolder Relationship,
  # - this function is recommended when accessing Profile database.

  # Access Point for Profile database
  # - Browse through all list of profile through UserHolder.
  # - UserHolder should be able to provide all brief info.
  # - Augments UserHolder fields or Implement reading from Profile if needed.
  def all_profile_info
    UserHolder.all
  end

  def profile_params
    params.permit(:first_name, :last_name, :email, :whatsapp, :address_line1, \
                  :address_line2, :city, :state, :country, :postal_code, :phone, \
                  :reached_through, :birthday, :sex, :health_plan, :contacts,
                  :weight, :height, :smoke, :smoke_a_day, :alcohol, :alcohol_use, \
                  :current_job, :exercise, :doctor)
  end

  # TODO creates corresponding controller and link to the profile model function here.
  # - Input: user_holder = ActiveRecord of UserHolder instance
  # - Link that direct to profile controller for that UserHolder
  def profile_link_create(user_holder)
    link_to "Profile", {:controller => "TODO", :action => "TODO", :user_holder_id => user_holder.id }
  end

  # Link Absorber, pairing with profile_link_create, receive and return profile through UserHolder
  # - Input: user_holder_id = id for UserHolder
  # - Output: Active Record of Profile
  def profile_link_absorber(user_holder_id)
    UserHolder.find_by_id(user_holder_id).profile
  end

  # Calculate age automatically from a birthday given.
  # The solution to this problem was found on StackOverflow, by Phil Nash.
  # https://stackoverflow.com/questions/819263/get-persons-age-in-ruby
  def calculate_age_from_birthday(dob)
    if dob.nil?
        return
    end
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
