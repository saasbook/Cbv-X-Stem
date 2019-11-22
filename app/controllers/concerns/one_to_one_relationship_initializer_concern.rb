module OneToOneRelationshipInitializerConcern
  extend ActiveSupport::Concern

  # puts your one_to_one method here, and declare your method at this concern
  # - Uses user_holder local variable as your relationship entry point.
  # - DO NOT change it to @user_holder, it will mask over the user holder policy initializer.
  def initialize_one_to_one_relationship_for_root_user
    set_patient_role_by_default
    user_holder = initialize_user_holder
    initialize_profile(user_holder)
  end

  def initialize_user_holder
    user_holder = current_user.user_holder
    if user_holder.nil?
      user_holder = UserHolder.create!(first_name: current_user.first_name,
                                      last_name: current_user.last_name,
                                      email: current_user.email,
                                      user_id: current_user.id)
    end
    return user_holder
  end

  def initialize_profile(user_holder)
    if user_holder.profile.nil?
      profile = Profile.create!(first_name: user_holder.first_name,
                              last_name: user_holder.last_name,
                              email: user_holder.email,
                              user_holder_id: user_holder.id)
    end
  end

  def set_patient_role_by_default
    if current_user.role.nil?
      current_user.role = "patient"
      current_user.save!
    end
  end

end
