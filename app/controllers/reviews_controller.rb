class ReviewsController < ApplicationController

  def create
    video = Video.find(params[:video_id])
    video.reviews.create(params[review_params])
    binding.pry
    redirect_to video_path(video)
  end

  private
    def review_params
      params.require(:review).permit(:video_id, :content, :rating).merge!(user_id: current_user.id)
    end
end