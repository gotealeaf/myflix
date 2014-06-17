class ReviewsController < ApplicationController

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.create(params[review_params])
    if review.save
      redirect_to video
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end