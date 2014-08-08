class Admin::VideosController < ApplicationController

  before_action :require_user, :require_admin

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

  private

  def video_params
    params.require(:video).permit!
  end

end
