class CategoriesController < ApplicationController
	before_action :setup_category, only: [:show]
	def index
		@categories = Category.all 
		render 'videos/index'
	end

	def show
	end

	private 

	def setup_category
		@category = Category.find(params[:id])
	end
end