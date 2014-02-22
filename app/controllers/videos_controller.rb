class VideosController < ApplicationController

	def index
		@videos = Video.all
		@comedy_category = Category.find(1)
		@drama_category = Category.find(2)
		@reality_category = Category.find(3)
		@comedy = @videos.comedy
		@drama = @videos.drama
		@reality = @videos.reality
		#@tv_comedies = Video.first(6)
		#@tv_dramas = Video.last(6)
	end

	def show
		@video = Video.find(params[:id])
	end

end