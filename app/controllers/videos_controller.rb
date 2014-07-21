class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update]


  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      flash[:success] = "A new video have been created."
      redirect_to root_path
    else
      render :new
    end
  end

  def search
    @videos = Video.search(params[:search]).paginate(:page => params[:page])
  end

  private
  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :description, :large_cover_image_url, :small_cover_image_url, :category_id )
  end

end
