class ReviewsController < ApplicationController
  before_filter :require_user
  
  def create
    @video = Video.find(params[:video_id])
    new_review = @video.reviews.build(setup_params.merge!(user: current_user))

    if new_review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private

  def setup_params
    params.require(:review).permit(:rating, :content)
  end
end