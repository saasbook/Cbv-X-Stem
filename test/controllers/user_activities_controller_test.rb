# require 'test_helper'
#
# class UserActivitiesControllerTest < ActionDispatch::IntegrationTest
#   include Devise::Test::IntegrationHelpers
#   def setup
#     @user = users(:patient_)
#     @user_holder = user_holders(:patient_holder)
#     @user_activity = user_activities(:ua1)
#     sign_in @user
#   end
#
#   test "should get index" do
#     get(user_holder_user_activities_path(@user_holder))
#     assert_response :success
#   end
#
#
#   test "should show user_activity" do
#     get(user_holder_user_activity_path(@user_holder, @user_activity))
#     assert_response :success
#   end
#   #
#   # test "should get edit" do
#   #   get edit_user_activity_url(@user_activity)
#   #   assert_response :success
#   # end
#   #
#   # test "should update user_activity" do
#   #   patch user_activity_url(@user_activity), params: { user_activity: { action: @user_activity.action, actor: @user_activity.actor, category: @user_activity.category, new_val: @user_activity.new_val, original_val: @user_activity.original_val, string: @user_activity.string, user_holder_id: @user_activity.user_holder_id } }
#   #   assert_redirected_to user_activity_url(@user_activity)
#   # end
#   #
#   # test "should destroy user_activity" do
#   #   assert_difference('UserActivity.count', -1) do
#   #     delete user_activity_url(@user_activity)
#   #   end
#   #
#   #   assert_redirected_to user_activities_url
#   # end
# end
