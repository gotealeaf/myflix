class VideosController < ApplicationController
	def home
		@videos = Video.all
		@categories = Category.all
		# binding.pry
	end

	def show
		@video = Video.find(params[:id])
	end

	def search
		@results = Video.search_by_title(params[:search_term])
	end
end
