class ReviewsController < ApplicationController
  before_action :require_user
  
  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.new(review_params)
    @review.user = current_user 
    if @review.save
      redirect_to @video
    else
      @video.reviews = @video.reviews.reload
      flash[:error] = "Sorry there was a problem saving your review."
      render 'videos/show'
    end
  end

  private
  def review_params 
    params.require(:review).permit!
  end
end
