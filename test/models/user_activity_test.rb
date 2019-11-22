# require 'test_helper'
#
# class UserActivityTest < ActiveSupport::TestCase
#   # test "the truth" do
#   #   assert true
#   # end
#   def setup
#     # @user = User.create!(first_name: "Nathaniel3", last_name: "Ng", email: "stoneplus20113@gmail.com", password: "password", password_confirmation: "password", is_doctor: false)
#     # @user_holder = UserHolder.create!(email: "stoneplus20112@gmail.com", first_name: "Nathaniel2",last_name: "Ng2",  user_id: @user)
#     # @user_activity = UserActivity.new!(actor: "Nathaniel", action: "create", category: "profile", original_val: "user profile", user_holder_id: @user_holder)
#     @user_activity = user_activities(:ua1)
#   end
#
#   # Database Entry
#   test "entry creation - UserActivity" do
#   	assert @user_activity.valid?
#   end
#
#   # Actor Field
#   test "required field - Actor" do
#   	@user_activity.actor = ""
#     assert_not @user_activity.valid?
#   end
#
#   test "field length max (20) - Actor" do
#   	@user_activity.actor = "a" * 21
#   	assert_not @user_activity.valid?
#   end
#
#   test "field length min (2) - Actor" do
#   	@user_activity.actor = "a" * 2
#   	assert_not @user_activity.valid?
#   end
#
#   # Action
#   test "required field - Action" do
#     @user_activity.action = ""
#     assert_not @user_activity.valid?
#   end
#
#   test "field length max (10) - Action" do
#     @user_activity.action = "a" * 11
#     assert_not @user_activity.valid?
#   end
#
#   test "field length min (2) - Action" do
#     @user_activity.action = "a" * 2
#     assert_not @user_activity.valid?
#   end
#
#   # Category
#   test "required field - Category" do
#     @user_activity.category = ""
#     assert_not @user_activity.valid?
#   end
#
#   test "field length max (10) - Category" do
#     @user_activity.category = "a" * 11
#     assert_not @user_activity.valid?
#   end
#
#   test "field length min (2) - Category" do
#     @user_activity.category = "a" * 2
#     assert_not @user_activity.valid?
#   end
#
#   # Original Value
#   test "required field - Original Value" do
#     @user_activity.original_val = ""
#     assert_not @user_activity.valid?
#   end
# end
