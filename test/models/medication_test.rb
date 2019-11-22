require 'test_helper'

class MedicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  require 'test_helper'
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:patient_)
    @user_holder = user_holders(:patient_holder)
    @medication = medications(:m11)
    sign_in @user
  end

  # Database Entry
  test "entry creation - Medication" do
    assert @medication.valid?
  end

  # Provider Field
  test "required field - Provider" do
    @medication.provider = ""
    assert_not @medication.valid?
  end

  test "field length max (20) - Provider" do
    @medication.provider = "a" * 21
    assert_not @medication.valid?
  end

  test "field length min (2) - Provider" do
    @medication.provider = "a" * 1
    assert_not @medication.valid?
  end

  # Directions Field
  test "required field - Directions" do
    @medication.directions = ""
    assert_not @medication.valid?
  end

  test "field length max (20) - Directions" do
    @medication.directions = "a" * 21
    assert_not @medication.valid?
  end

  test "field length min (2) - Directions" do
    @medication.directions = "a" * 1
    assert_not @medication.valid?
  end

  # Days Field
  test "required field - Days" do
    @medication.days = ""
    assert_not @medication.valid?
  end

  test "field length max (20) - Days" do
    @medication.days = "a" * 21
    assert_not @medication.valid?
  end

  test "field length min (2) - Days" do
    @medication.days = "a" * 1
    assert_not @medication.valid?
  end

end
