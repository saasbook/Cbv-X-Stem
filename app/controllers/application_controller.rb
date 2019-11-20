class ApplicationController < ActionController::Base
  include DevisePermittedAttributes
  include ApplicationHelper
  include ProfileHelper
  # check_authorization
  before_action :getUserHolderWithDefaultCreation

end
