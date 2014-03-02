class VideosController < ApplicationController
  def index
    @category_videos = {}
    Category.all.each do |category|
      @category_videos.merge!(category => category.videos)
    end
  end

  def show
    @video = Video.find(params[:id])
  end
end
