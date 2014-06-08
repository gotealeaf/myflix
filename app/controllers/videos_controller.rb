class VideosController < ApplicationController
  before_action :require_user, only: [:index, :show, :search]
    
  def index
    @categories = Category.all
  end
  
  def show
    @video = VideoDecorator.decorate(Video.find(params[:id]))
    @reviews = @video.reviews
  end
  
  def search
    @results = Video.search_by_title(params[:title])   
  end
  
end