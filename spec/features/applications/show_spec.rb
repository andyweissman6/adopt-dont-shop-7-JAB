require "rails_helper"

#[ ] done

# 1. Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

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

# 4. Searching for Pets for an Application

# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search