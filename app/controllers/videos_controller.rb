class VideosController < ApplicationController
  def index
    @categories = Category.order(:name)
  end

  def show
    @video = Video.find params[:id]
  end

  def search
    @videos = Video.search_by_title(params[:search_word])
  end
end
