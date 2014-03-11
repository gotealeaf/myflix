class ReviewsController < ApplicationController
  before_action :current_user

  def create
    @video = Video.find_by(params[:id])
    review = @video.reviews.create(review_params.merge!(user: current_user, video_id: @video.id))

    if review.save
      redirect_to @video
    else
      render 'videos/show'
    end
  end

  private 

    def review_params
      params.require(:review).permit(:user_review, :rating, :video_id, :user_id)
    end
end