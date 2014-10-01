class Admin::VideosController < AdminsController
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "'#{@video.title}' has been added"
      redirect_to new_admin_video_path
    else
      flash[:error] = "Please correct the errors"
      render :new
    end
    
  end

  def video_params
    params.require(:video).permit(:title, :url, :url_large, :description, :category_id, :large_cover, :small_cover, :video_url)
  end
end