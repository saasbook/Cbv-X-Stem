class ApplicationController < ActionController::Base
  include DevisePermittedAttributes
  include ApplicationHelper
  include ProfileHelper
  
end
