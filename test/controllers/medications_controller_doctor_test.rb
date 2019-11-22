require 'test_helper'

class MedicationsControllerDoctorTest < ActionDispatch::IntegrationTest

  def setup
    @user_doctor = users(:doctor_)
    @user_doctor_holder = user_holders(:doctor_holder)
    sign_in @user_doctor
    @user_patient_holder = user_holders(:patient_holder)
    @medication = medications(:m11)
  end

  test "should get index" do
    get(user_holder_medications_path(@user_patient_holder))
    assert_response :success
  end

  test "should show medication" do
    get(user_holder_medication_path(@user_patient_holder, @user_patient_holder.medications.first))
    assert_response :success
  end

  test "should get new" do
    get(new_user_holder_medication_path(@user_patient_holder))
    assert_response :success
  end

  test "should get edit" do
    get edit_user_holder_medication_path(@user_patient_holder, @user_patient_holder.medications.first)
    assert_response :success
  end

  test "should create medication" do
    assert_difference('Medication.count') do
      post "/user_holders/" + @user_patient_holder.id.to_s + "/medications", params: { user_holder: @user_patient_holder, medication: { description: "aaaaa", directions: "aaaaa", provider: "aaaaa", days: "aaaaa", user_holder_id: @medication.user_holder_id, name: "aaaaa",} }
    end
    # assert_redirected_to user_holder_medication_path(@user_holder, Treatment.last)
    assert_redirected_to user_holder_medications_path(@user_patient_holder)
  end

  test "should update medication" do
    patch "/user_holders/" + @user_patient_holder.id.to_s + "/medications/" + @medication.id.to_s, params: { user_holder: @user_patient_holder, medication: { description: "aaaaa", directions: "aaaaa", provider: "aaaaa", days: "aaaaa", user_holder_id: @medication.user_holder_id, name: "aaaaa",} }
    assert_redirected_to user_holder_medications_path(@user_patient_holder)
  end

  test "should destroy medication" do
    assert_difference('Medication.count', -1) do
      delete "/user_holders/" + @user_patient_holder.id.to_s + "/medications/" + @medication.id.to_s, params: { user_holder: @user_patient_holder}
    end
    assert_redirected_to user_holder_medications_path(@user_patient_holder)
  end

end
