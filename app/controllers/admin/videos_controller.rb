class Admin::VideosController < AdminController
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "The video #{@video.title} has been saved!"
      redirect_to new_admin_video_path
    else 
      flash[:danger] = "The video could not be saved, due to the following errors:"
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :category_id, :description, 
                                  :small_cover, :large_cover, :video_url)
  end
end