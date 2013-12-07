class VideosController < ApplicationController

  def index
  @videos = Video.all
  end

  def show
  @videos = Videos.find(params[:id])
  end
 
end
