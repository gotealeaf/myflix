class VideosController < ApplicationController

  def index
    @videos = Video.all
    @categories = Category.all
    @video = Video.find(params[:id])
  end

  def show
    @video = Video.find(params[:id])
  end
end