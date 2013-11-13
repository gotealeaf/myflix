class VideosController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def show
    @results = Video.search_by_title(params[:search_term])
  end

end
