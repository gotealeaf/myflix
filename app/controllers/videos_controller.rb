class VideosController < ApplicationController

  def index
    @categories = Category.all
  end

  def search
    @videos = Video.search_by_title(params[:search])
  end

  def show
    @video = Video.find(params[:id])
  end
end