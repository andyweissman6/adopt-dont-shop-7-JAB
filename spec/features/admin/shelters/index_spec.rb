require "rails_helper"

RSpec.describe "Admin Shelters Index Page", type: :features do
  let!(:shelter2) { Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5) }
  let!(:shelter3) { Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10) }
  let!(:shelter1) { Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9) }

  describe 'displays records in reverse alphabetical order by name' do
    it 'should display shelter names in reverse alphabetical order' do
      visit "/admin/shelters"

      expect(shelter2.name).to appear_before(shelter3.name)
      expect(shelter3.name).to appear_before(shelter1.name)
    end
  end
end