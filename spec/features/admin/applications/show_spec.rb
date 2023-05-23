require "rails_helper"


RSpec.describe "Admin Applications Show Page", type: :feature do
  let!(:applicant1) { Application.create!( name: "Bruce", 
                                            street_address: "123 Main Street", 
                                            city: "Denver", 
                                            state: "CO", 
                                            zip_code: "12345", 
                                            status: "In Progress", 
                                            description: "Cat Lover")}
  
  let!(:applicant2) { Application.create!( name: "Maurice", 
                                            street_address: "345 Blue Street", 
                                            city: "Palisade", 
                                            state: "CO", 
                                            zip_code: "56421", 
                                            status: "In Progress", 
                                            description: "Gator Lover")}

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
  
  let!(:pet_application2) {PetApplication.create!(  pet_id: pet1.id,
                                              application_id: applicant2.id)}

  describe "Status button for application submitted" do
    it "adds a button to approve pet application and displays an indicator next to the pet that they have been approved" do

      visit "/admin/applications/#{applicant1.id}"

      expect(page).to have_content("Ralph")
      expect(page).to have_button("Approve The Application")
      click_button("Approve The Application")
      
      expect(current_path).to eq("/admin/applications/#{applicant1.id}")
      expect(page).to_not have_button("Reject The Application")
      expect(page).to have_content("Approved")
    end
    
    it "adds a button to reject pet application and displays an indicator next to the pet that they have been rejected" do

      visit "/admin/applications/#{applicant1.id}"

      expect(page).to have_content("Ralph")
      expect(page).to have_button("Reject The Application")
      click_button("Reject The Application")
      
      expect(current_path).to eq("/admin/applications/#{applicant1.id}")
      expect(page).to_not have_button("Reject The Application")
      expect(page).to have_content("Rejected")
    end
  end

  describe "Approved/Rejected Pets on one Application do not affect other Applications" do
    it "should not display indicator on an application when another application has accpeted or rejected a pet" do
      visit "/admin/applications/#{applicant1.id}"
      expect(page).to have_content("Ralph")
      expect(page).to have_button("Reject The Application")
      click_button("Reject The Application")
      expect(current_path).to eq("/admin/applications/#{applicant1.id}")
      expect(page).to have_content("Rejected")
      

      visit "/admin/applications/#{applicant2.id}"
      expect(page).to have_content("Ralph")
      expect(page).to have_button("Reject The Application")
      expect(page).to_not have_content("Rejected")
    end
  end
end