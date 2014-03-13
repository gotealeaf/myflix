class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params)
    @review.creator = current_user
    if @review.save
      flash[:success] = "Thanks for the review, #{current_user.full_name}!"
      redirect_to video_path(@video)
    else
      if @review.errors.messages[:user_id]
        flash[:danger] = "Sorry, you can only review a video once."
      else
        flash[:danger] = "Sorry, your review needs revision to be accepted."
      end
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :review_text, :video_id)
  end
end