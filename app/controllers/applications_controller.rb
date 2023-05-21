class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @found_pets = Pet.search(params[:search]).adoptable
    end
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

  def update
    application = Application.find(params[:id])
    application.update(application_params)
    redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
