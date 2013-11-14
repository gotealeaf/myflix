class VideosController < ApplicationController
  before_action :require_user
  
  def index
    @videos = Video.all
    @categories = Category.all
  end
  
  def search
    @results = Video.search_by_name(params[:search])
    render search_videos_path
  end
  
  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
    @average_rating = @reviews.average('rating')
  end
end