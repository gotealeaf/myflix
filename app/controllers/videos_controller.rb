class VideosController < ApplicationController
  before_filter :require_user
  
  def index
    @categories = Category.all
  end

  def search
    @videos = Video.search_by_title(params[:title])
  end

  def show
    @video = VideoDecorator.decorate(Video.find(params[:id]))
    @reviews = @video.reviews.load
  end
end