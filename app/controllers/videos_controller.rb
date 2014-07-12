class VideosController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
  end

  def search
    @videos_searched = Video.search_by_title(params[:search_term])
  end

end