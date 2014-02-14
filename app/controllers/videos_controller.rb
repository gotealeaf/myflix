class VideosController < ApplicationController
  def home
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end
end