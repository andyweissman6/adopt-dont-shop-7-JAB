require "rails_helper"

RSpec.describe "Applications Show Page", type: :feature do

  let!(:applicant1) { Application.create!( name: "Bruce", 
                                            street_address: "123 Main Street", 
                                            city: "Denver", 
                                            state: "CO", 
                                            zip_code: "12345", 
                                            status: "In Progress", 
                                            description: "Cat Lover")} 
  
  let!(:shelter1) { Shelter.create!(  name: "RM Animal Shelter", 
                                      foster_program: true, 
                                      city: "Denver", 
                                      rank: 4)} 
  
  let!(:pet1) { shelter1.pets.create!(  name: "Ralph", 
                                        adoptable: true, 
                                        age: 6, 
                                        breed: "Calico")} 
  
  let!(:pet2) { shelter1.pets.create!(  name: "Mr. Ralph", 
                                        adoptable: true, 
                                        age: 3, 
                                        breed: "Clydesdale")} 
  
  let!(:pet_application1) {PetApplication.create!(  pet_id: pet1.id,
                                                    application_id: applicant1.id)}

  describe "displays the attributes of an applicant" do
    it "should display the name, full address, description, status, and adoptees" do
      visit "/applications/#{applicant1.id}"
      expect(page).to have_content(applicant1.name)
      expect(page).to have_content(applicant1.street_address)
      expect(page).to have_content(applicant1.city)
      expect(page).to have_content(applicant1.state)
      expect(page).to have_content(applicant1.zip_code)
      expect(page).to have_content(applicant1.status)
      expect(page).to have_content(applicant1.description)
      expect(page).to have_content(applicant1.pets.name)
    end
  end

  describe "Searching for Pets for an Application" do
    it "should display a section that allows you to search for pets" do
      visit "/applications/#{applicant1.id}"
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_button("Find Pet")
      
      
      fill_in(:search, with: "Ralph")
      click_button("Find Pet")
      

      expect(current_path).to eq("/applications/#{applicant1.id}")
      expect(page).to have_content("Ralph")
      expect(page).to have_content("Mr. Ralph")
      
    end
  end
end
