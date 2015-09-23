class VideosController < ApplicationController
  def index
    binding.pry
    @videos = Video.all
    binding.pry
  end
end