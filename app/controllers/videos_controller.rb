class VideosController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @results = Video.search_by_title(params[:search_term])
    if @results == []
      @nothing_found = true
    else
      @nothing_found = false
    end
  end

end