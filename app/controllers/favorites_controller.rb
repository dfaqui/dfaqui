class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    favorite = Favorite.new(
      user:             current_user,
      favoritable_id:   params[:id],
      favoritable_type: params[:type]
    )

    favorite.favorite
  end

  def destroy
  end
end
