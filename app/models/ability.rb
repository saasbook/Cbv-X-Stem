class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      # :read, :create, :update, :destroy
      if !user.nil? && user.is_doctor?
        can :manage, Appointment
        can :manage, Documentation
        can :manage, Document
        can :manage, Medication
        can :manage, Meeting
        can :manage, Profile
        can :manage, Treatment
        can :read, UserActivity #It is a log from the system - Only systemAdmin can change it.
        can :manage, UserSetting
        can :read, UserHolder # UserHolder is controlled by the system - Only systemAdmin can change it.
      end

      if !user.nil? && !user.is_doctor?
        can :manage, Appointment
        can [:read, :update], Documentation # Only the doctor can create and delete a document.
        can [:read, :update], Document # Only the doctor can create and delete a document.
        can [:read], Medication # Only the doctor can create, update and delete a medication.
        can :manage, Meeting
        can :manage, Profile
        can [:read], Treatment # Only the doctor can create, update and delete a treatment.
        can :read, UserActivity #It is a log from the system - Only systemAdmin can change it.
        can :manage, UserSetting
        can :read, UserHolder # UserHolder is controlled by the system - Only systemAdmin can change it.
      end
  end
end
