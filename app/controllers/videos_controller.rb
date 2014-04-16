class VideosController < ApplicationController
  before_action :video_params, only: [:create, :edit, :update]
    
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
    @video = Video.find(params[:id])
  end
  
end