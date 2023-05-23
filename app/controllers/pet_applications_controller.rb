class PetApplicationsController < ApplicationController
  def create
    pet_application = PetApplication.create!(pet_application_params)
    application = pet_application.application
    redirect_to "/applications/#{application.id}"  
  end

  def update
    pet_application = PetApplication.find(params[:id])
    application = pet_application.application
    pet_application.update(pet_application_params)
    redirect_to "/admin/applications/#{application.id}"
  end

  private
  def pet_application_params
    params.permit(:application_id, :pet_id, :pet_status)
  end
end