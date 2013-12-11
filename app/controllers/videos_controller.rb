class VideosController < ApplicationController
  def index
    @categories = Category.all.sort_by{|x| x.name}
  end

  def show
    @video = Video.find(params[:id])
  end
end