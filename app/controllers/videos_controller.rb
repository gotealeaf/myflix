class VideosController < ApplicationController
  
  layout "application"
  before_action :require_user
  
  def index
    @videos = Video.all
    @categories = Category.all.sort_by {|cat| cat.name}
  end
  
  def show
    @video = Video.find(params[:id])
  end
  
  def search
    @search_term = params[:search_term]
    @videos = Video.search_by_title(params[:search_term])
    render 'search'
  end
  
end