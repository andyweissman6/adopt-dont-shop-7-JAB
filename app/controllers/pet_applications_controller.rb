class PetApplicationsController < ApplicationController
  def create
    application = Application.find(params[:application_id])
    pet_application = PetApplication.create!(pet_application_params)
    redirect_to "/applications/#{application.id}"  
  end

  private
  def pet_application_params
    params.permit(:application_id, :pet_id, :pet_status)
  end
end