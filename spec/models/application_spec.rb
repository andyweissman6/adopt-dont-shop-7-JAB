require "rails_helper"

RSpec.describe Application, type: :model do
  let!(:applicant1) { Application.create!(  name: "Bruce", 
                                            street_address: "123 Main Street", 
                                            city: "Denver", 
                                            state: "CO", 
                                            zip_code: "12345", 
                                            description: "Cat Lover",
                                            status: "Pending")} 
  
  let!(:shelter1) { Shelter.create!(  name: "RM Animal Shelter", 
                                      foster_program: true, 
                                      city: "Denver", 
                                      rank: 4)} 
  
  let!(:pet1) { shelter1.pets.create!(  name: "Ralph", 
                                        adoptable: true, 
                                        age: 6, 
                                        breed: "Calico")} 
  
  let!(:pet2) { shelter1.pets.create!(  name: "Mr.Ralph", 
                                        adoptable: true, 
                                        age: 3, 
                                        breed: "Clydesdale")} 
  
  let!(:pet_application1) {PetApplication.create!(  pet_id: pet1.id,
                                                    application_id: applicant1.id)}
  describe "relationships" do
    it { should have_many(:pet_applications)}
    it { should have_many(:pets).through(:pet_applications)}
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    # it { should validate_presence_of(:description) }
    it { should validate_length_of(:zip_code).is_equal_to(5) }
  end

  describe "instance methods" do
    it "#find_pet_app" do
      expect(applicant1.find_pet_app(pet1.id)).to eq(pet_application1)
    end
  end

  describe "class methods" do
    it "::pending_apps" do

      expect(Application.pending_apps).to eq([applicant1])
    end
  end
end