class VideosController < ApplicationController
  def index
    @videos = Video.all.sort_by{|x| x.category}
  end

  def show
    @video = Video.find(params[:id])
    # @video = Video.find_by(slug: params[:id])
  end
end