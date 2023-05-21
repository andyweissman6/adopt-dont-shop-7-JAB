require "rails_helper"

RSpec.describe "Application new page" do
  describe "displays a form to create a new application record" do
    it "should display a form that has name, full address, description" do

      visit "/applications/new"

      fill_in(:name, with: "Ryan Reynolds")
      fill_in("Street Address", with: "Ryan Reynolds LN")
      fill_in(:city, with: "Ryan Reynoldsville")
      fill_in(:state, with: "CA")
      fill_in(:zip_code, with: "69402")
      fill_in(:description, with: "I am DEADPOOL")

      click_button("Create New Application")

      expect(current_path).to eq("/applications/#{Application.all.first.id}")
      expect(page).to have_content("Ryan Reynolds")
      expect(page).to have_content("Ryan Reynolds LN")
      expect(page).to have_content("Ryan Reynoldsville")
      expect(page).to have_content("CA")
      expect(page).to have_content("69402")
      expect(page).to have_content("In Progress")
      expect(page).to have_content("I am DEADPOOL")
    end
  end

  describe "displays an error message when field(s) are incomplete" do
    it 'should display an error message when one or more fields are not filled' do
      visit "/applications/new"

      fill_in(:name, with: "Ryan Reynolds")
      fill_in("Street Address", with: "")
      fill_in(:city, with: "Ryan Reynoldsville")
      fill_in(:state, with: "CA")
      fill_in(:zip_code, with: "69")
      fill_in(:description, with: "I am DEADPOOL")

      click_button("Create New Application")
      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("ERROR: Form incomplete, please fill in all fields")
    end
  end
end
