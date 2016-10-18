class MarketsController < ApplicationController
  include ApplicationHelper

  has_scope :cidade
  has_scope :quadras
  has_scope :quadra
  has_scope :segmento
  has_scope :categoria
  has_scope :especialidade
  has_scope :cep

  def index
    channel = (current_channel == 'comercio') ? 'market' : current_channel
    @buttons = SponsorButton.by_city(params[:cidade]).with_channel(channel.to_sym)
  end

  def list
    @markets = apply_scopes(Market).by_channel(current_channel)
  end

  def show
    @market = Market.find(params[:market_id])
  end
end
