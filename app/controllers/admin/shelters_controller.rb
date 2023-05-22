class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_names_desc
  end
end