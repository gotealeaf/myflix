class VideosController < ApplicationController
  def index 
    @categories = Category.all
    if params[:category].blank?
      @videos = Video.all
    else
      @videos = Video.find_by_category(params[:category])
    end
  end

  def show
    @video = Video.find_by_id(params[:id])
  end

  def search
    @categories = Category.all
    @videos = Video.search_by_title(params[:search_term])
  end
end
