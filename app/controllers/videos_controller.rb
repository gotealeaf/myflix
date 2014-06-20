class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def index
    @genres = Genre.all
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def edit
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
    @results = Video.search_by_name(params[:name])
  end

  private

  def set_video
    @video = Video.find_by(slug: params[:id])
  end

  def video_params
    params.require(:video).permit!
  end
end
