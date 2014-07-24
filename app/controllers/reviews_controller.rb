class ReviewsController < ApplicationController
  before_action :signed_in_user
  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params)
    @review.creator = current_user
    if @review.save
      flash[:success] = "New review has been created."
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end
  private

    def review_params
      params.require(:review).permit(:rating, :content, :video_id, :user_id)
    end
end
