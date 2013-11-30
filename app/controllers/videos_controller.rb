class VideosController < ApplicationController
	def home
		@videos = Video.all
		# binding.pry
	end

end