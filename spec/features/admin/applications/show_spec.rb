require "rails_helper"


RSpec.describe "Admin Applications Show Page", type: :feature do
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

  let!(:pet_application1) {PetApplication.create!(  pet_id: pet1.id,
                                              application_id: applicant1.id)}

  describe "Approval button for application submitted" do
    it "adds a button to approve pet application and displays an indicator next to the pet that they have been approved" do

      visit "/admin/applications/#{applicant1.id}"

      expect(page).to have_content("Ralph")
      expect(page).to have_button("Approve The Application")
      click_button("Approve The Application")
      
      expect(current_path).to eq("/admin/applications/#{applicant1.id}")
      expect(page).to_not have_button("Approve The Application")
      expect(page).to have_content("Approved")
    end
  end
end
# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved