class VideosController < ApplicationController
  before_action :set_video, only: [:show]

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def show
  end

  def search
    @video_array = Video.search_by_title(params[:search_term])
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end