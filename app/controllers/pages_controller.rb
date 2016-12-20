class PagesController < ApplicationController
  layout 'clean'

  def home
  end

  def dynamic_content
    condition = (params[:cidade].present?) ? params[:cidade] : 'default'

    @title = Page.where(code: 'home-title', condition: condition).pluck(:value).first
    @link = Page.where(code: 'home-pin-link', condition: condition).pluck(:value).first

    @link = @link.html_safe if @link
  end

  def terms
  end
end
