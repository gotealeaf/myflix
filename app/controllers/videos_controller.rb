class VideosController < ApplicationController

	def index		
	end

	def show
		@video = Video.find(params[:id])
	end

  def search
    @results = Video.search(params[:query])

  end
end