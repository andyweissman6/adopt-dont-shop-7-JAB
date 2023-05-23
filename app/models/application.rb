class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, length: { is: 5 }
  # validates :description, presence: true
  
  def self.pending_apps
    Application.joins(pet_applications:[{pet: :shelter}]).where("applications.status = 'Pending'")
  end

  def find_pet_app(pet_id)
    pet_applications.where(pet_id: pet_id).first
  end
end