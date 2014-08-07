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
end
