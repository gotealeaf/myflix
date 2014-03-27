class PagesController < ApplicationController

	def index
    redirect_to videos_path if current_user
	end

end