module CentralizedUserHolderAndUserConcern
  extend ActiveSupport::Concern

  def user_role_policy_index_map
    {
      :guest => 0,
      :patient =>1,
      :doctor => 2,
    }
  end

  def user_holder_policy_map
    {
      # ControllerName => [guest_policy, patient_policy, doctor_policy]
      # Available Policy::
      # - RTU:: Root User Holder - Refers to the actual user account
      # - SSU:: Sessional User Holder - Overrides by Resource Parameters for UserHolder & Keep current UserHolder if not nil
      # - NAC:: Not Accessible - Current Resource Access should not be accessible by current user - Error Raising and Redirect
      # - OPT:: Opt Off - Have user holder as is, still support fall back for Guest User Holder

      # Non-inherited access is always root user holder.
      :ApplicationController => ['RTU', 'RTU', 'RTU'],
      # Both doctor and patient have their own resouces, not Accessible by other.
      :AppointmentsController => ['NAC', 'RTU','RTU'],
      # Patient have their own Resource | Doctor can access patient Resource in Session.
      :MedicationsController => ['NAC', 'RTU','SSU'],
      # Specific Resource for Doctor - not accessible by Patient.
      :MeetingsController => ['NAC', 'NAC','RTU'],
      # Both doctor and patient have their own resouces, not Accessible by other.
      :MessagesController => ['RTU', 'RTU','RTU'],
      # Both doctor and patient have their own resouces, not Accessible by other.
      :PagesController => ['RTU', 'RTU','RTU'],
      # Not following Convention - Have their own User Holder Handler.
      :PatientsController => ['OPT', 'OPT','OPT'],
      # Specific Resource for Doctor - not accessible by Patient.
      :SearchPatientsController => ['NAC', 'NAC','RTU'],
      # Patient have their own Resource | Doctor can access patient Resource in Session.
      :TreatmentsController => ['NAC', 'RTU','SSU'],
      # Not following Convention - Have their own User Holder Handler.
      :DocumentationsController => ['OPT', 'OPT', 'OPT'],
      # Both doctor and patient have their own resouces, not Accessible by other.
      :UserActivitiesController => ['NAC', 'RTU','RTU'],
    }
  end

  # Resource Orientation Policy for User Holder
  # - Value for Current User Holder is based on the Policy specified for the current Controller
  def initialize_user_and_user_holder(current_user)
    # (3) TestUserHolder for Doctor
    # if test_user flag is on, we will be anchoring with the current_user_holder
    # until it is reset to root_user by doctor_button or top_nav_bar
    # exception: current_user_holder.nil? = true

    # (2) Setting UserHolder by UserHolderPolicy
    # get_current_user
    # initialize_user_holder_for_current_user

    # gets the current Controller to access user_holder_policy_map
    # retrieves policy based on the role of the user

    currentController = self.class.to_s.to_sym
    # HACK:: patient_index == null - because I am too lazy to fix setting the role in registration.
    user_index = user_role_policy_index_map[current_user.role && current_user.role.to_sym] || 1
    user_holder_policy = user_holder_policy_map[currentController] && user_holder_policy_map[currentController][user_index]

    case user_holder_policy
    # if NAC, redirect_to root_path
    when 'OPT'
      puts "Caution, you choose to opt off from centralized user holder system, please defines your own rule for user holder handling."
      return
    when 'NAC'
      flash[:notice] = 'Denial Access in Resource Level'
      redirect_to root_path
    # if SSU, overrides the UserHolder by params[:user_holder]
    when 'SSU'
      # if params specifies its own user holder, use it
      if !params[:user_holder].nil? then
        @user_holder = params[:user_holder]
      else
        # if user_holder null, fall back to root user.
        if @user_holder.nil? then
          @user_holder = current_user.user_holder
        end
      end
    # if RTU, sets UserHolder to RootUserHolder
    when 'RTU'
      @user_holder = current_user.user_holder
    else
    # (Default-Accept) if policy is not specified, consider as OPT-OUT
      puts "Caution, you have not specified your policy in centralized user holder system."
      return
    end
  end


end
