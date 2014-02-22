class VideosController < ApplicationController

	def index
		@comedy_category = Category.find(1)
		@drama_category = Category.find(2)
		@reality_category = Category.find(3)
	end

	def show
		@video = Video.find(params[:id])
	end

end