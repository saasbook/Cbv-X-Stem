require 'rails_helper'

RSpec.describe Treatment, type: :model do




  context "db" do
    fixtures :treatments
    it "Creation of Treatment - Provider column" do
      test_treatment = treatments(:t1)
      expect(test_treatment.provider).to eq("provider1")
    end
    it "Creation of Treatment - Location column" do
      test_treatment = treatments(:t1)
      expect(test_treatment.location).to eq("location1")
    end
    it "Creation of Treatment - Status column" do
      test_treatment = treatments(:t1)
      expect(test_treatment.status).to eq("status1")
    end
    it "Creation of Treatment - Name column" do
      test_treatment = treatments(:t1)
      expect(test_treatment.name).to eq("name1")
    end
    it "Creation of Treatment - Description column" do
      test_treatment = treatments(:t1)
      expect(test_treatment.description).to eq("description1")
    end
    it "Creation of Treatment - user_holder_id column" do
      test_treatment = treatments(:t1)
      expect(test_treatment.user_holder_id).to eq(1)
    end

  end

end
