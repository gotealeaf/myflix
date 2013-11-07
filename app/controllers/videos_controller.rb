class VideosController < ApplicationController 
  
  def index 
    @videos = Video.all
    @categories = Category.all
  end

  def show 
    @video = Video.find params[:id]
    render 'video_show'
  end
end