class VideosController < ApplicationController
  before_action :require_user

  def index
  	@category = Category.all
  end

  def show
  	@video = Video.find(params[:id])
  	@review = @video.reviews
  end

  def searchresults
  	@videos = Video.search_by_title("#{params[:query]}") 	
  end
end