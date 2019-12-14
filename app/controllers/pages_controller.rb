class PagesController < ApplicationController

  def home
    if current_user.user_holder.nil?
      redirect_to root_path
    end
    if current_user.role == 'patient'
    @booked = Meeting.where(patient_id: current_user.id).where(status: "confirmed")
    end
    if current_user.role == 'doctor'
    @booked = Meeting.where(user_holder_id: current_user.id).where(status: "confirmed")
    end

  end

  def about
  end

  def contact
  end
end
