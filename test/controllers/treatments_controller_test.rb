# require 'test_helper'
#
# class TreatmentsControllerTest < ActionDispatch::IntegrationTest
#   def setup
#     @user = login
#     @user_holder = set_user_holder(@user)
#     @treatment1 = set_treatment(@user_holder)
#   end
#
#   test "should get index" do
#     byebug
#     get(user_holder_treatments_path(@user.user_holder))
#     assert_response :success
#   end
#
#
#   test "should show treatment" do
#     get(user_holder_treatment_path(@user.user_holder, @user.user_holder.treatments.first))
#     assert_response :success
#   end
#
#
# # For doctor Feature - New, Create, Edit, Update, Destroy
#
#   test "should get new" do
#     get(new_user_holder_treatment_path(@user.user_holder))
#     assert_response :success
#   end
#
#   # test "should create treatment" do
#   #   assert_difference('Treatment.count') do
#   #     post "/treatment/create", params: { user_holder: @user_holder, treatment: { description: "aaaaa", location: "aaaaa", provider: "aaaaa", status: "aaaaa", user_holder_id: @treatment.user_holder_id, name: "aaaaa",} }
#   #   end
#   #   # assert_redirected_to user_holder_treatment_path(@user_holder, Treatment.last)
#   #   assert_redirected_to user_holder_treatments_path(@user_holder)
#   # end
#
#   test "should get edit" do
#     get edit_user_holder_treatment_path(@user.user_holder, @user.user_holder.treatments.first)
#     assert_response :success
#   end
#
#   # test "should update treatment" do
#   #   patch "/treatment/update", params: { user_holder: @user_holder, treatment: { name: "t1-2", description: @treatment.description, location: @treatment.location, provider: @treatment.provider, status: @treatment.status, user_holder_id: @treatment.user_holder_id } }
#   #   assert_redirected_to user_holder_treatment_path(@user_holder, Treatment.last)
#   # end
#   #
#   # test "should destroy treatment" do
#   #   assert_difference('Treatment.count', -1) do
#   #     delete "/treatment/destroy", params: { user_holder: @user_holder, treatment: @treatment }
#   #   end
#   #   assert_redirected_to user_holder_treatments_path(@user_holder)
#   # end
# end
