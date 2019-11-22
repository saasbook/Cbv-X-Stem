class ApplicationController < ActionController::Base
  #Concern
  include DevisePermittedAttributes
  include CentralizedUserHolderAndUserConcern
  include UserFallBackConcern
  #Helper
  include ApplicationHelper
  include ProfileHelper

  # check_authorization
  before_action do
    centralized_user_related_initializer(current_user)
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

end
