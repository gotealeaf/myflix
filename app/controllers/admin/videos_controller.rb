class Admin::VideosController < AdminsController

  def new
      @video = Video.new
  end
  
  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "You have successfully added #{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:danger] = "There was an error. Your video could not be added."
      render :new
    end
  end
  
  private
  
  def video_params
    params.require(:video).permit(:title, :description, :large_cover, :small_cover, :url, category_ids:[])
  end
  
end