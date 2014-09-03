class VideosController < ApplicationController

  before_filter :logged_in?

  def index 
    @categories = Category.all
  end

  def show
    @video = Video.find_by_id(params[:id])
    @reviews = Review.where(video_id: @video.id)
  end

  def search
    @categories = Category.all
    @videos = Video.search_by_title(params[:search_term])
  end
end
