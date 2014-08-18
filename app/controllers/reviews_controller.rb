class ReviewsController < ApplicationController
  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params.merge!(user: current_user))
    redirect_to video
  end

private
  def review_params
     params.require(:review).permit(:user_id, :video_id, :content, :rating)
  end

end
