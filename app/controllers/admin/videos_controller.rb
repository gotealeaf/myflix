class Admin::VideosController < AuthorizationController
  def new
    @video = Video.new
  end
end
