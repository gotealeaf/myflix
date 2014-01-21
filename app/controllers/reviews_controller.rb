class ReviewsController < ApplicationController
  before_action :require_user
  
  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.new(review_params)
    if review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end
  
  def review_params
    params.require(:review).permit(:video_id, :user_id, :content, :rating)
  end
end



