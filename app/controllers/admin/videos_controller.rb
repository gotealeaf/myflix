class Admin::VideosController < ApplicationController

  before_action :require_user, :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:notice] = "#{@video.name} has been added successfully!"
      redirect_to new_admin_video_path
    else
      flash[:danger] = "Video could not be uploaded, please check errors."
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit!
  end

end
