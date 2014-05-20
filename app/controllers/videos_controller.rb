class VideosController < ApplicationController
  before_filter :find_video, only: [:show]
  
  def show
  end
  
  private
  
  def find_video
    @video = Video.find(params[:id])
  end
end
