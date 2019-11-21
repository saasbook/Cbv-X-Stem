class PagesController < ApplicationController
  skip_authorize_resource

  def home
    if current_user.user_holder.nil?
      redirect_to root_path
    end
  end

  def about
  end

  def contact_general
  end
end
