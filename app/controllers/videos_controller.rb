class VideosController < ApplicationController
  def home
    @categories = Category.all
  end
  
  def show
    @video = Video.find(params[:id])
  end

  def search
    @results = Video.search_by_title(params[:search_term])
  end
end
