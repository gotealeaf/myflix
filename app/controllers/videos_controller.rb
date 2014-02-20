class VideosController < ActionController::Base
	layout "application"

	def home
		@tv_comedies = Video.first(6)
		@tv_dramas = Video.last(6)
	end

end