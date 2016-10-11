class MarketsController < ApplicationController
  include ApplicationHelper

  def index
    @buttons = SponsorButton.by_plugin(current_channel.to_sym)
  end

  def list
    @markets = Market.all
  end
end
