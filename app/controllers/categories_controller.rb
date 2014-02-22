class CategoriesController < ApplicationController
	def show
		@categories = Category.find(params[:id])
	end
end