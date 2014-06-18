class VideosController < ApplicationController
  before_filter :require_user
  
  def index
    @categories = Category.all
  end

  def show
    find_video
  end
  
  def search
    @results = Video.search_by_title(params[:search_term])
  end

  private
  
  def find_video
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end

end