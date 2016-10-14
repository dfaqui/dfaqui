class MarketsController < ApplicationController
  include ApplicationHelper

  def index
    channel = (current_channel == 'comercio') ? 'market' : current_channel
    @buttons = SponsorButton.by_plugin(channel.to_sym)
  end

  def list
    @markets = Market.all
  end
end
