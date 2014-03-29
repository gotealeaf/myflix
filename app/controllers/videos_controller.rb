class VideosController < ApplicationController
  before_action :require_user
  before_action :set_video, only: [:show]

  def index
    @categories = Category.all
  end

  def show
    @reviews = @video.reviews
  end

  def search
    @videos = Video.search_by_title(params[:search_term])
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end
