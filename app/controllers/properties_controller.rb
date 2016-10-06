class PropertiesController < ApplicationController
  def index
  end

  def show
    @property = Property.find(params[:property_id])
  end

  def list
    @properties = Property.all
  end
end
