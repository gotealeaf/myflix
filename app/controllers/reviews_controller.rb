class ReviewsController < ApplicationController
  def create
    require_user and return

    @video = Video.find(params[:video_id])
    @review = review_params.merge(user: current_user)
    @review = @video.reviews.build(@review)

    if @review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      @average_rating = average_rating(@reviews)
      render 'videos/show'
    end
  end

  private

  def review_params 
    params.require(:review).permit(:content, :rating)
  end
end