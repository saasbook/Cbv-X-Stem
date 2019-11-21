class PagesController < ApplicationController
  skip_authorize_resource
  def home
    if current_user.role != 'guest'
        # get userholder instance, else create one.
        # holder = getUserHolderWithDefaultCreation
        # if no profile yet, create one.
        @current_profile = getProfileWithDefaultCreation(@user_holder)
    end
  end

  def about
  end

  def contact_general
  end
end
