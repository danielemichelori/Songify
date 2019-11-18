class StaticPagesController < ApplicationController

  def concerts
    remote = Songkickr::Remote.new ENV["SONGKICK_API_KEY"]
    @results = remote.events(location: "clientip").results
  end
end
