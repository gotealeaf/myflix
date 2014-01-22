class VideosController < ApplicationController

  def index
  @categories = Category.all
  end

  def show
   @videos = Video.find(params[:id])
end

  def search
   @results =  Video.search_by_name(params[:search_term])
  end

end
