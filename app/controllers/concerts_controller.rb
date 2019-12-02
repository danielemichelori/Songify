class ConcertsController < ApplicationController
    
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
        return "No event found"
    end 
end
