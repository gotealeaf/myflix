class ReviewsController < ApplicationController
  before_filter :user_required!

  def create
    @video = Video.find(params[:video_id])

    @new_review = Review.new(review_params)
    @new_review.tap do |r|
      r.user  = current_user
      r.video = @video
    end

    if @new_review.save
      redirect_to video_path(@new_review.video_id)
    else
      @reviews = @video.reviews
      @rating  = @reviews.any? ? @reviews.average(:rating).round(1) : 0

      render "videos/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:video_id, :rating, :comment)
  end
end
