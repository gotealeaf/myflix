class VideosController < ApplicationController
  def index
    @categories = Category.all
    @show_videos_per_category = 6
  end

  def show
    @video = Video.find(params[:id])
  end
end