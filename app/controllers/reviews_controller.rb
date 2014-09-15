class ReviewsController < ApplicationController

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to video_path(@video)
    end
  end

  private

  def review_params
    params.require(:review).permit!
  end
end
