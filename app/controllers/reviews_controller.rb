class ReviewsController < ApplicationController
  before_filter :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.video = @video
    if @review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      flash[:error] = "Please write a review."
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end