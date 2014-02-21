class VideosController < ApplicationController

	def index
		@videos = Video.all
		@comedy = Category.find(1)
		@drama = Category.find(2)
		@reality = Category.find(3)
		#@tv_comedies = Video.first(6)
		#@tv_dramas = Video.last(6)
	end

	def show
		@video = Video.find(params[:id])
	end

end