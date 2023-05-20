class ApplicationsController < ApplicationController
  
  def show
    @application = find_a_pet
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "ERROR: Form incomplete, please fill in all fields"
    end
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end

  def find_a_pet
    if !params[:search].nil?
      Application.all.first.pets.search_pet(params[:search])
    else
      Application.find(params[:id])
    end
  end
end
