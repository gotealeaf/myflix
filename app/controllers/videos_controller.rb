class VideosController < ApplicationController
	before_action :get_video, only: [:show]

	def index
		@categories = Category.all
	end

	def show
	end

	private

	def get_video
		@video = Video.find(params[:id])
	end
end