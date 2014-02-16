class VideosController < ApplicationController
  def index
    @categories = Category.all.sort_by { |x| x.title }
  end

  def show
    @video = Video.find_by id: params[:id]
  end
end