class VideosController < ApplicationController
  def index
    @videos = Video.all
  end
end
