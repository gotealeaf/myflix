class VideosController < ApplicationController
  def show
  	@video = Video.first
  end
end
