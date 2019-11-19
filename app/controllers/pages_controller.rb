class PagesController < ApplicationController
  def home
    if not current_user.nil?
        # get userholder instance, else create one.
        holder = getUserHolderWithDefaultCreation
        # if no profile yet, create one.
        @current_profile = getProfileWithDefaultCreation(holder)
    end
  end

  def about
  end

  def contact_general
  end
end
