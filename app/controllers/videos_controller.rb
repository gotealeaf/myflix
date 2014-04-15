class VideosController < ApplicationController

  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(3)
  end

end
