class VideosController < ApplicationController
  before_filter :require_user

  def index
    @categories = Category.all.sort_by{|x| x.name}
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @search_term = params[:search_term]
    @videos = Video.search_by_title(@search_term)
  end
end