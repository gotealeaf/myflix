class VideosController < ApplicationController
  def index
    @videos = Video.all
  end
  
  def search
    @results = Video.search_by_name(params[:search])
    render search_videos_path
  end
  
  def show
    @video = Video.find(params[:id])
  end
end