class ReviewsController < ApplicationController

  before_action :require_user

  def create
    @video = Video.find(params[:video_id]) 
    @review = @video.reviews.build(review_params) #.merge!(user_id: current_user.id)
    @review.user = current_user
    if @review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      flash[:error] = "Sorry there was a problem saving your review."
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :video_id, :user_id)
  end
end
