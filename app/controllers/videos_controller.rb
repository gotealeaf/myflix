class VideosController < ApplicationController
	def home
		@videos = Video.all
		@categories = Category.all
		# binding.pry
	end

	def show
		@video = Video.find(params[:id])
	end
end