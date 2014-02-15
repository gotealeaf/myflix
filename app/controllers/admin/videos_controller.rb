class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(video_params) 
    if @video.save
      flash[:success] = "created video successfully!"
      redirect_to new_admin_video_path
    else
      flash[:error] = "missing video info"
      render :new 
    end
  end

  private 
  
  def require_admin
    if !current_user.admin?
      flash[:error] = "Need admin user!"
      redirect_to home_path
    end
  end

  def video_params
    params.require(:video).permit!
  end
end
