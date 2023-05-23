class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_names_desc
    @applications = Application.pending_apps
  end
end