class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(video_params)
    if @video.save
      flash[:success] = "You have successfully added the video '#{@video.title}'"
      redirect_to new_admin_video_path
    else
      flash[:error] = "You cannot add this video. Please check the errors."
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit!
  end

  def require_admin
    unless current_user.admin?
      flash[:error] = "Access denied."
      redirect_to home_path
    end
  end
end