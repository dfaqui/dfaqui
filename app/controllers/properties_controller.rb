class PropertiesController < ApplicationController
  has_scope :tipo
  has_scope :situacao
  has_scope :quartos
  has_scope :area
  has_scope :cidade
  has_scope :quadras
  has_scope :quadra
  has_scope :bloco
  has_scope :cep

  def index
    @buttons    = SponsorButton.with_channel(:property).by_city(params[:cidade])
    @properties = SponsorItem.where(sponsorable_type: 'Property').by_city(params[:cidade])
  end

  def show
    @property = Property.find(params[:property_id])
  end

  def list
    @properties = apply_scopes(Property).all
  end
end
