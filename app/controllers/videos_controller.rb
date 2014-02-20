class VideosController < ApplicationController

	def index
		@show = Video.find_by(params[:id])
		#@tv_comedies = Video.first(6)
		#@tv_dramas = Video.last(6)
	end

	def show
		@video = Video.find_by(params[:id])
	end

end