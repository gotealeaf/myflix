class VideosController < ApplicationController


  def front

  end

  def home
    @videos = Video.all
    @categories = Category.all
    
  end

  def show
    @video = Video.find(params[:id])
  
  end

  def search
    
    @results = Video.search_by_title(params[:search_term])
    
  end



end
