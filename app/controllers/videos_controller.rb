class VideosController < ApplicationController
	before_action :set_video, only: [:show]

	def index
		@categories = Category.all
	end

	def show
	end

  def search
    @results = Video.search_by_title(params[:search_term])
  end

	private

	def set_video
		@video = Video.find(params[:id])
	end

end