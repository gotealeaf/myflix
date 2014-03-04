class VideosController < ApplicationController
  def index
    #binding.pry
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @search_results = Video.search_by_title(params[:search])
  end
end