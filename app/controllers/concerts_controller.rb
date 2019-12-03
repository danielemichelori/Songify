class ConcertsController < ApplicationController
    before_action :require_login

    def require_login
      unless current_user != nil
      flash[:error] =  "You require to login!"
        redirect_to new_user_session_path # halts request cycle
      end
    end

    remote = Songkickr::Remote.new ENV["SONGKICK_API_KEY"]
    @@results = remote.events(location: "clientip").results

    def index
        @results = @@results
    end

    def show
        @events = @@results
        @event = search(@events, params[:id])
    end

    private
    def search(results, id)
        results.each do |event|
            if(event.id ==  id.to_i)
                return event
            end
        end
        render_not_found
    end

    private
    def render_not_found
        render :file => "#{Rails.root}/public/404.html",  :status => 404
    end

    private
    def get_artist_bio(artist)
        lastfm = Lastfm.new(ENV["LASTFM_API_KEY"], ENV["LASTFM_API_SECRET"])
        token = lastfm.auth.get_token
        lastfm.session = lastfm.auth.get_session(token: token)['key']

        return lastfm.artist.getInfo(artist: artist)
    end
end
