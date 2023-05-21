Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

applicant1 = Application.create!( name: "Bruce", 
street_address: "123 Main Street", 
city: "Denver", 
state: "CO", 
zip_code: "12345",  
description: "Cat Lover") 

applicant2 = Application.create!( name: "Mike", 
street_address: "420 Baller Street", 
city: "Boulder", 
state: "CO", 
zip_code: "12345",
status: "Approved",
description: "Dog Lover") 

shelter1 = Shelter.create!(  name: "RM Animal Shelter", 
foster_program: true, 
city: "Denver", 
rank: 4) 

pet1 = shelter1.pets.create!(  name: "Ralph", 
adoptable: true, 
age: 6, 
breed: "Calico") 

pet2 = shelter1.pets.create!(  name: "Mr. Ralph", 
adoptable: true, 
age: 3, 
breed: "Clydesdale") 

pet_application1 = PetApplication.create!(  pet_id: pet1.id,
        application_id: applicant1.id)
