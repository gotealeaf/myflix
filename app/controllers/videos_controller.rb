class VideosController < ApplicationController

  def index
  @videos = Video.all
  debugger
  end

  def show
  @videos = Videos.find(params[:id])
  end
 
end
