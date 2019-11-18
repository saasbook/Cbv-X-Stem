class ApplicationController < ActionController::Base
  include DevisePermittedAttributes
  include ApplicationHelper
  include ProfileHelper

  before_action :getUserHolderWithDefaultCreation

end
