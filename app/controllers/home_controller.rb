class HomeController < ApplicationController
	def index
		@videos = Video.all
		@categories = Category.all
	end
end