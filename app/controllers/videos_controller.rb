class VideosController < ApplicationController
  before_filter :require_user
  
  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end

  def search
    @results = Video.search_by_title(params[:search_term])
  end

end
