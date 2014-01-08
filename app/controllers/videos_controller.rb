class VideosController < ApplicationController
  def home
    @categories = Category.all
  end
  
  def show
    @video = Video.find(params[:id])
  end
end
