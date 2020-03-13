class ValuationsController < ApplicationController
	 respond_to :js, :json, :html

	def new
		super	  
	end

	def index
		@val = Valuation.all
	end

	def create
		@val = Valuation.new
		@val.artist = params[:artist]
		@val.user = current_user
		@val.value = params[:value]
		@val.save
		redirect_to artist_path(id: params[:artist]), :notice => "Reviewed."

	end
end
