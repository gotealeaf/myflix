class VideosController < ApplicationController
  before_action :setup_videos, only: [:home]
  before_action :set_video, only: [:show]

  def home
  end

  def show
    render :video
  end


  private

  def setup_videos
    @videos = Video.all
  end

  def set_video
    @video = Video.find(params[:id])
  end
end