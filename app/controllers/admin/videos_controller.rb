class Admin::VideosController < AdminController
  before_action :authorize, :ensure_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "You sucessfully added the video, #{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = "Invalid inputs. Please try again."
      render :new
    end
  end

private

  def video_params
    params.require(:video).permit(:title, :category_id, :description, :large_cover, :small_cover, :video_url)
  end
end