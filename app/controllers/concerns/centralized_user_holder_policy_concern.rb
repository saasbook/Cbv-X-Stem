module CentralizedUserHolderPolicyConcern
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
      :ApplicationController => ['OPT', 'OPT', 'OPT'],
      # Both doctor and patient have their own resouces, not Accessible by other.
      :AppointmentsController => ['OPT', 'OPT','OPT'],
      # Patient have their own Resource | Doctor can access patient Resource in Session.
      :MedicationsController => ['NAC', 'RTU','SSU'],
      # Specific Resource for Doctor - not accessible by Patient.
      :MeetingsController => ['OPT', 'OPT','OPT'],
      # Both doctor and patient have their own resouces, not Accessible by other.
      :MessagesController => ['OPT', 'OPT','OPT'],
      # Both doctor and patient have their own resouces, not Accessible by other.
      :PagesController => ['OPT', 'OPT','OPT'],
      # Not following Convention - Have their own User Holder Handler.
      :PatientsController => ['OPT', 'OPT','OPT'],
      # Specific Resource for Doctor - not accessible by Patient.
      :SearchPatientsController => ['OPT', 'OPT','OPT'],
      # Patient have their own Resource | Doctor can access patient Resource in Session.
      :TreatmentsController => ['NAC', 'RTU','SSU'],
      # Not following Convention - Have their own User Holder Handler.
      :DocumentationsController => ['NAC', 'SSU', 'SSU'],
      # Both doctor and patient have their own resouces, not Accessible by other.
      :UserActivitiesController => ['NAC', 'RTU','RTU'],
    }
  end

end
