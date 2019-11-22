require 'test_helper'

class TreatmentTest < ActiveSupport::TestCase
  require 'test_helper'
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:patient_)
    @treatment = treatments(:t1)
    sign_in @user
  end

  # Database Entry
  test "entry creation - Treatment" do
  	assert @treatment.valid?
  end

  # Provider Field
  test "required field - Provider" do
  	@treatment.provider = ""
    assert_not @treatment.valid?
  end

  test "field length max (20) - Provider" do
  	@treatment.provider = "a" * 21
  	assert_not @treatment.valid?
  end

  test "field length min (3) - Provider" do
  	@treatment.provider = "a" * 2
  	assert_not @treatment.valid?
  end

  # Status Field
  test "required field - Status" do
  	@treatment.status = ""
    assert_not @treatment.valid?
  end

  test "field length max (20) - Status" do
  	@treatment.status = "a" * 21
  	assert_not @treatment.valid?
  end

  test "field length min (2) - Status" do
  	@treatment.status = "a" * 1
  	assert_not @treatment.valid?
  end

  # Name Field
  test "required field - Name" do
    @treatment.name = ""
    assert_not @treatment.valid?
  end

  test "field length max (20) - Name" do
    @treatment.name = "a" * 21
    assert_not @treatment.valid?
  end

  test "field length min (3) - Name" do
    @treatment.name = "a" * 2
    assert_not @treatment.valid?
  end

  # Description Field
  test "required field - Description" do
    @treatment.description = ""
    assert_not @treatment.valid?
  end

  # Foreign Key Field
  test "required field - user_holder_id" do
    @treatment.user_holder_id = ""
    assert_not @treatment.valid?
  end

end
