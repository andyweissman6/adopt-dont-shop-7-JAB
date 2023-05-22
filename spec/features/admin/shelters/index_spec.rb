require "rails_helper"

RSpec.describe "Admin Shelters Index Page", type: :features do
  let!(:shelter2) { Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5) }
  let!(:shelter3) { Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10) }
  let!(:shelter1) { Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9) }

  let!(:applicant1) { Application.create!( name: "Bruce", 
                                            street_address: "123 Main Street", 
                                            city: "Denver", 
                                            state: "CO", 
                                            zip_code: "12345", 
                                            status: "In Progress")} 
  
  let!(:applicant2) { Application.create!( name: "Tommy", 
                                            street_address: "567 Down Street", 
                                            city: "Palisade", 
                                            state: "CO", 
                                            zip_code: "80808", 
                                            status: "Pending")}
  
  let!(:pet1) { shelter1.pets.create!(  name: "Ralph", 
                                            adoptable: true, 
                                            age: 6, 
                                            breed: "Calico")} 

  let!(:pet_application1) {PetApplication.create!(  pet_id: pet1.id,
                                                    application_id: applicant2.id)}

  describe 'displays records in reverse alphabetical order by name' do
    it 'should display shelter names in reverse alphabetical order' do
      visit "/admin/shelters"

      expect(shelter2.name).to appear_before(shelter3.name)
      expect(shelter3.name).to appear_before(shelter1.name)
    end
  end

  describe "Name of every shelter that has a pending application" do
    it "should display a section with names of shelters with pending applications" do
      visit "/admin/shelters"
      expect(page).to have_content("Shelters with Pending Applications")
      expect(page).to have_content("Aurora shelter")
    end
  end
end

# For this story, you should fully leverage ActiveRecord methods in your query.

# 11. Shelters with Pending Applications

# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see a section for "Shelters with Pending Applications"
# And in this section I see the name of every shelter that has a pending application