class VideosController < ApplicationController

  before_action :set_video, except: [:index, :new, :search]
  before_action :require_user

  def index
    @genres = Genre.all
  end

  def show
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    # To do: Associate genre
    if @video.save
      flash[:notice] = "#{video.name} has been added successfully!"
      redirect_to home_path
    else
      render :new
    end
  end

  def search
    @results = Video.search_by_name(params[:search_name])
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit!
  end
end
