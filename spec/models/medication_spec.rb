require 'rails_helper'

RSpec.describe Medication, type: :model do

  context "db" do
    fixtures :medications

    it "Creation of Medication - Name column" do
      test_medication = medications(:m11)
      expect(test_medication.name).to eq("name11")
    end
    it "Creation of Medication - Provider column" do
      test_medication = medications(:m11)
      expect(test_medication.provider).to eq("provider11")
    end
    it "Creation of Medication - Direction column" do
      test_medication = medications(:m11)
      expect(test_medication.directions).to eq("directions11")
    end
    it "Creation of Medication - Days column" do
      test_medication = medications(:m11)
      expect(test_medication.days).to eq("days11")
    end
    it "Creation of Medication - Description column" do
      test_medication = medications(:m11)
      expect(test_medication.description).to eq("description11")
    end
    it "Creation of Medication - user_holder_id column" do
      test_medication = medications(:m11)
      expect(test_medication.user_holder_id).to eq(1)
    end

  end

end
