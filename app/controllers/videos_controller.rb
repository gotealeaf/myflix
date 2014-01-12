class VideosController < ApplicationController
  before_action :require_user

  def index
    @videos = Video.all
  end
  def show
    @video = Video.find(params[:id])
  end


  def search
    @results = search_by_title(params[:search_term])
    
  end
        
  def edit
  end

  def new
  end

  private

  def self.search_by_title(search_term)
  where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

end
