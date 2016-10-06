class PropertiesController < ApplicationController
  def index
  end

  def show
  end

  def list
    @properties = Property.all
  end
end
