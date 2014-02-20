class VideosController < ActionController::Base
	layout "application"

	def home
		@show = Video.find_by(params[:id])
		#@tv_comedies = Video.first(6)
		#@tv_dramas = Video.last(6)
	end

	def video
		@video = Video.find_by(params[:id])
	end

end