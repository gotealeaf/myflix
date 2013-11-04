class VideosController < ApplicationController
	before_action :set_video, only: [:show, :edit, :update, :destroy]

	def index	
		@videos = Video.all
		@categories = Category.all
	end

	def show
	end

	def set_video
		@video = Video.find(params[:id])
	end
end