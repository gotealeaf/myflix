class VideosController < ActionController::Base

	def home
		@videos = Video.all
	end
end