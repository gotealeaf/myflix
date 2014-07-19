class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update]

  def show
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :descriptiom, :large_cover_image_url, :small_cover_image_url)
  end

end
