ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'capybara/rails'
require 'rails/test_help'

class ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def login
    user = User.create!(
      :first_name => 'Nathaniel',
      :last_name => 'Ng',
      :email => 'test01@test.com',
      :password => 'password',
      :password_confirmation => 'password'
    )
    sign_in user
    user
    # user.confirm!
  end

  def set_user_holder(user)
    user_holder = UserHolder.create!(
      :first_name => 'Nathaniel',
      :last_name => 'Ng',
      :email => 'test01@test.com',
      :user_id => user.id
    )
    user_holder
  end

  def set_treatment(user_holder)
    treatment = Treatment.create!(
      :provider => 'aaaaa',
      :location => 'aaaaa',
      :status => 'aaaaa',
      :name => 'aaaaa',
      :description => 'aaaaa',
      :user_holder_id => user_holder
    )
    treatment
  end


  #
  # # Add more helper methods to be used by all tests here...
  # # Returns true if a test user is logged in.
  # def is_logged_in?
  #   !session[:user_id].nil?
  # end
  #
  # # Logs in a test user.
  # def log_in_as(user, options = {})
  #   password    = options[:password]    || 'password'
  #   is_doctor    = options[:is_doctor]    || false
  #   if integration_test?
  #     post login_path, session: { email: user.email, password: password, password_confirmation: password, first_name: user.first_name, last_name: user.last_name, is_doctor: is_doctor}
  #   else
  #     session[:user_id] = user.id
  #   end
  # end
  #
  # private
  #
  # # Returns true inside an integration test.
  # def integration_test?
  #   defined?(post_via_redirect)
  # end
end

# class ActionController::TestCase
#   include Devise::TestHelpers
# end
