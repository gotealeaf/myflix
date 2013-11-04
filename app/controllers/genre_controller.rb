class GenreController < ApplicationController
	before_action :set_category, only: [:show, :edit, :update, :destroy]

	def index
		@categories = Category.all
	end

	def show
	end

	def set_category
		@category = Category.find(params[:id])
	end
end