class ReviewsController < ApplicationController
  before_action :current_user

  def create
    video = Video.find_by(params[:id])
    review = Review.new(review_params.merge!(user: current_user))
    review = video.reviews.create

    redirect_to video_path(video)
  end

  private 

    def review_params
      params.require(:review).permit(:user_review, :rating, :video, :user)
    end
end