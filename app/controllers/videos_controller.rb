class VideosController < ApplicationController

  def index
    @videos = Video.all
  end

  def show

  end
end