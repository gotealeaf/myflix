class VideosController < ApplicationController
  before_action :require_user

  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end


  def search
    @results = Video.search_by_title(params[:search_term])

  end
        
  def edit
  end

  def new
  end

  private 

 def  video_params
  params.require(:video).permit(reviews_attributes: [:id, :rating, :content, :video_id, :user_id])
   
 end
  
end
