class VideosController < ApplicationController

  def index
    if params[:search_term]
      @videos = Video.find(:all, :conditions => ['title LIKE ?', "%#{params[:search_term]}%".order('created_at DESC')])
    else
      @videos = Video.find(:all)
    end
  end

  def show
    @video = Video.first
  end
end