require 'lastfm'

class ArtistsController < ApplicationController
    before_action :require_login

    def require_login
      unless current_user != nil
      flash[:error] =  "You require to login!"
        redirect_to new_user_session_path # halts request cycle
      end
    end

    def index
       @topArtists = show_top_artists
    end

    def show 
        @artists = show_top_artists
        @artist = get_artist_by_name(@artists,params[:id])
    end

    private
    def show_top_artists
        lastfm = Lastfm.new(ENV["LASTFM_API_KEY"], ENV["LASTFM_API_SECRET"])
        token = lastfm.auth.get_token
        return lastfm.chart.get_top_artists
    end

    private
    def get_artist_by_name(artists,name) 
        artists.each do |artist|
            if(name == artist['name'])
                return artist
            end
        end
        render_not_found
    end

    private
    def render_not_found
        render :file => "#{Rails.root}/public/404.html",  :status => 404
    end

    
end
