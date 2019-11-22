require 'test_helper'

class MedicationsControllerPatientTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:patient_)
    @user_holder = user_holders(:patient_holder)
    @medication = medications(:m11)
    sign_in @user
  end

  test "should get index" do
    get(user_holder_medications_path(@user.user_holder))
    assert_response :success
  end


  test "should show medication" do
    get(user_holder_medication_path(@user.user_holder, @user.user_holder.medications.first))
    assert_response :success
  end

  test "should get new" do
    get(new_user_holder_medication_path(@user.user_holder))
    assert_response :redirect
  end

  test "should get edit" do
    get edit_user_holder_medication_path(@user.user_holder, @user.user_holder.medications.first)
    assert_response :redirect
  end

end
