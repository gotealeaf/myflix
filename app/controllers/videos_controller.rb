class VideosController < ApplicationController
  before_action :require_user

  def index
    @videos = Video.all
  end
  def show
    @video = Video.find(params[:id])
  end


  def search
    @results = Video.search_by_title(params[:search_term])

  end
        
  def edit
  end

  def new
  end

  
end
