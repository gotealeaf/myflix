class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find_by id: params[:id]
  end
end
