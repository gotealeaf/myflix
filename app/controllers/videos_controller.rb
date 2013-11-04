class VideosController < ApplicationController

  def index
  	@videos = Video.first(6)
  end

  def show
  	@video = Video.find(params[:id])
  end

end