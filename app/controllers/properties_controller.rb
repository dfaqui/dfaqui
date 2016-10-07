class PropertiesController < ApplicationController
  def index
    @sponsors = Sponsor.by_plugin(:property)
  end

  def show
    @property = Property.find(params[:property_id])
  end

  def list
    @properties = Property.all
  end
end
