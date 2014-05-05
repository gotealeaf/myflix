class Admin::VideosController < AdminController
  def new
    @video = Video.new
  end

  def create
    binding.pry
  end
end