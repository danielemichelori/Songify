class FavoritesController < ApplicationController
  def update
    favorite = Favorite.where(musicevent_id: MusicEvent.find(params[:musicevent_id]), user: current_user)
    if favorite == []
      # Create the favorite
      Favorite.create(musicevent_id: MusicEvent.find(params[:musicevent_id]), user: current_user)
      @favorite_exists = true
    else
      # Delete the favorite
      favorite.destroy_all
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
end
