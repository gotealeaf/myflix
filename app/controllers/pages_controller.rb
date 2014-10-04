class PagesController < ApplicationController
	def home
		@category = Category.all
	end
end