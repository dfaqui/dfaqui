class PropertiesController < ApplicationController
  def index
    @buttons    = SponsorButton.by_plugin(:property)
    @properties = SponsorItem.where(sponsorable_type: 'Property')
  end

  def show
    @property = Property.find(params[:property_id])
  end

  def list
    @properties = Property.all
  end
end
