module CentralizedUserHolderAndUserConcern
  extend ActiveSupport::Concern
  # Access to UserHolderPolicy
  include CentralizedUserHolderPolicyConcern
  include OneToOneRelationshipInitializerConcern

  def get_user_holder_policy
    currentController = self.class.to_s.to_sym
    # HACK:: patient_index == null - because I am too lazy to fix setting the role in registration.
    user_index = user_role_policy_index_map[current_user.role && current_user.role.to_sym] || 1
    user_holder_policy = user_holder_policy_map[currentController] && user_holder_policy_map[currentController][user_index]
    user_holder_policy
  end

  def set_user_holder_for_sessional_usage(current_user)
    # if params specifies its own user holder, use it
    if !params[:user_holder_id].nil? then
      @user_holder = UserHolder.find_by_id(params[:user_holder_id])
    else
      # if user_holder null, fall back to root user.
      if @user_holder.nil? then
        @user_holder = current_user.user_holder
      end
    end
  end

  # Resource Orientation Policy for User Holder
  # - Value for Current User Holder is based on the Policy specified for the current Controller
  def centralized_user_related_initializer(current_user)
    initialize_one_to_one_relationship_for_root_user

    case get_user_holder_policy
    # if NAC, redirect_to root_path
    when 'NAC'
      flash[:notice] = 'Denial Access in Resource Level'
      redirect_to root_path
    # if SSU, overrides the UserHolder by params[:user_holder]
    when 'SSU'
      set_user_holder_for_sessional_usage(current_user)
    # if RTU, sets UserHolder to RootUserHolder
    when 'RTU'
      @user_holder = current_user.user_holder
    # when 'OPT'
    else
    # (Default-Accept) if policy is not specified, consider as OPT-OUT
      puts "Caution, you have not specified your policy in centralized user holder system."
      puts "Your user_holder will fall back to root_user if nil"
      if @user_holder.nil? then @user_holder = current_user.user_holder end
      return
    end
  end

end
