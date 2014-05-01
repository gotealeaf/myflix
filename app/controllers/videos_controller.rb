class VideosController < ApplicationController
  before_action :require_user, only: [:index, :show, :search]
    
  def index
    @categories = Category.all
  end
  
  def show
    @video = Video.find(params[:id])
  end
  
  def search
    @results = Video.search_by_title(params[:title])    
  end
  
end