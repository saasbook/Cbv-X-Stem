# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # :read, :create, :update, :destroy


    # Doctor Access Control Policy
    if !user.nil? && user.is_doctor?
      can :manage, Appointment
      can :manage, Documentation
      can :manage, Document
      can :manage, Medication
      can :manage, Meeting
      can :manage, Message, user_holder_id: user.user_holder.id
      can :manage, Profile
      can :manage, Treatment
      can :read, UserActivity #It is a log from the system - Only systemAdmin can change it.
      can :manage, UserSetting
      can :read, UserHolder # UserHolder is controlled by the system - Only systemAdmin can change it.
    end

    # Patient Access Control Policy
    if !user.nil? && !user.is_doctor?
      can :manage, Appointment, user_holder_id: user.user_holder.id
      can [:read, :update], Documentation, user_holder_id: user.user_holder.id # Only the doctor can create and delete a document.
      can [:read, :update], Document, user_holder_id: user.user_holder.id # Only the doctor can create and delete a document.
      can [:read], Medication, user_holder_id: user.user_holder.id # Only the doctor can create, update and delete a medication.
      can :manage, Meeting, user_holder_id: user.user_holder.id
      can :manage, Message, user_holder_id: user.user_holder.id
      can :manage, Profile, user_holder_id: user.user_holder.id
      can [:read], Treatment, user_holder_id: user.user_holder.id # Only the doctor can create, update and delete a treatment.
      can :read, UserActivity, user_holder_id: user.user_holder.id #It is a log from the system - Only systemAdmin can change it.
      can :manage, UserSetting, user_holder_id: user.user_holder.id
      can :read, UserHolder, user_holder_id: user.user_holder.id # UserHolder is controlled by the system - Only systemAdmin can change it.
    end

    # Guest Access Control Policy
    can :manage, Message

  end
end
