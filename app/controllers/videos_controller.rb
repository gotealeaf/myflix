class VideosController < ApplicationController
  before_action :set_video, only: [:show]
  before_action :require_user

  def index
    @categories = Category.all
  end

  def show

  end

  def search
    @videos = Video.search_by_title(params[:search_term])
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end
