class VideosController < ApplicationController
  before_action :video_params, only: [:create, :edit, :show, :update]
  before_action :require_video, only: [:edit, :update, :show]
    
  def index
    @videos = Video.all
  end
  
  def new
    @video = Video.new
  end
  
  def create
    @video = Video.new(video_params)
  end
  
  def edit
  end
  
  def update
  end
  
  def show
  end
  
  private
  
  def video_params
    params.require(:video).permit(:title, :description)
  end
end