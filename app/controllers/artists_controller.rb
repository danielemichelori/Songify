require 'lastfm'
require 'httparty'

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
        @bio = get_artist_bio(params[:id])
        @id = get_id_by_name(params[:id])
    end

    private
    def show_top_artists
        lastfm = Lastfm.new(ENV["LASTFM_API_KEY"], ENV["LASTFM_API_SECRET"])
        token = lastfm.auth.get_token
        return lastfm.chart.get_top_artists
    end

    private
    def get_artist_bio(name)
         lastfm = Lastfm.new(ENV["LASTFM_API_KEY"], ENV["LASTFM_API_SECRET"])
         token = lastfm.auth.get_token
         bio =  lastfm.artist.get_info(artist: name)
         return bio
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
    def get_id_by_name(name)
        response = HTTParty.get('https://api.songkick.com/api/3.0/search/artists.json?apikey='+ ENV['SONGKICK_API_KEY'] + '&query='+name+'')
        @resultsPage = JSON.parse(response.body)
        return @resultsPage["resultsPage"]["results"]["artist"][0]["id"]
    end

    private
    def render_not_found
        render :file => "#{Rails.root}/public/404.html",  :status => 404
    end


end
