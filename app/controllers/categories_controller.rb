class CategoriesController < ApplicationController
	def show
		#@categories = Category.all
		@videos = Video.all
		@categories = Category.find(params[:id])
		@comedy = Video.comedy
		@drama = Video.drama
		@reality = Video.reality
	end

	def comedy
		@comedy = Video.comedy
	end

	def drama
		@drama = Video.drama
	end

	def reality
		@reality = Video.reality
	end
end