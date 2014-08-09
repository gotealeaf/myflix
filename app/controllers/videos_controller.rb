class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update]
  before_action :signed_in_user, except: :index

  def index
    @categories = Category.all
  end

  def show
    @reviews = @video.reviews
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

  private
    def set_video
      @video = Video.find_by(token: params[:id])
    end

    def video_params
      params.require(:video).permit(:title, :description, :large_cover_image_url, :small_cover_image_url, :category_id )
    end
end
