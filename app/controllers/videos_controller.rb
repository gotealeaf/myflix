class VideosController < ApplicationController

	def index
		@categories = Category.all
	end

	def show
		@video = Video.find(params[:id])
	end

  def search
    if params[:search] 
      @results = Video.search_by_title(params[:search])
    end
  end

end