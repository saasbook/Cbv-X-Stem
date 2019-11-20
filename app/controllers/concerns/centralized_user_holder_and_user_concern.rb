module CentralizedUserHolderAndUserConcern
  extend ActiveSupport::Concern

  def get_user_holder_policy_map
    user_holder_policy_map = {
      # ControllerName => [patient_policy, doctor_policy]
      :ApplicationController => ['R', 'R'],
      :AppointmentsController => ['R','R'],
      :MedicationsController => ['R','R'],
      :MeetingsController => ['R','R'],
      :MessagesController => ['R','R'],
      :PagesController => ['R','R'],
      :PatientsController => ['R','R'],
      :SearchPatientsController => ['R','R'],
      :TreatmentsController => ['R','R'],
      :UserActivitiesController => ['R','R'],
    }
  end

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
    user = get_root_user_with_guest_default

    # if X, redirect_to root_path
    # if R, sets UserHolder to RootUserHolder
    # if O, overrides the UserHolder by params[:user_holder]

  end

  def get_root_user_with_guest_default

  end



end
