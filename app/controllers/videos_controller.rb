class VideosController < ApplicationController
  def index
    @videos = Video.all.sort_by{|x| x.title}
  end
end