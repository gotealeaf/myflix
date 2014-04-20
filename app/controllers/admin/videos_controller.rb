class Admin::VideosController < AdminController
  before_action :authorize, :ensure_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:notice] = "You sucessfully added the video"
      redirect_to category_path(@video.category.id)
    else
      flash[:notice] = "Invalid inputs. Please try again."
      render :new
    end
  end

private

  def video_params
    params.require(:video).permit(:title, :category_id, :description, :large_cover, :small_cover)
  end
end