class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find_by(params[:id])
  end
end
