class ReviewsController < ApplicationController
  before_filter :require_user

  def create
    @video = Video.find(params[:video_id])
    user = current_user

    review = Review.new(review_params)
    review.video = @video
    review.creator = user

    if review.save
      flash[:notice] = "Your review has been added."
      redirect_to @video
    else
      flash[:error] = "Your review could not be addded: #{ review.errors.first.to_s }"
      @reviews = @video.reviews
      render "videos/show"
    end    
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :video_id)
  end
   
end