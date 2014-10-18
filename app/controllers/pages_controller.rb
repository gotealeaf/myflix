class PagesController < ApplicationController
	def home

		@category = Category.all
	end

	def index
		redirect_to videos_path if logged_in?
	end
end