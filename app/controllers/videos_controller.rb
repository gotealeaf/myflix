class VideosController < ApplicationController
  def index
    @category_videos = {}
    Category.all.each do |category|
      @category_videos.merge!(category => category.recent_videos)
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title(params[:q])
  end
end
