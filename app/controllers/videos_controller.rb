class VideosController < ApplicationController

  def index
   @categories = Category.all
  end

  def show
    @video = Video.first
  end
end