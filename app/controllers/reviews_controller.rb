class ReviewsController < ApplicationController
  before_action :current_user

  def create
    video = Video.find_by(params[:id])
    review = Review.new(params[review_params].merge!(user_id: current_user, video_id: video))
    review = video.reviews.create

    redirect_to video_path(video)
  end

  private 

    def review_params
      params.require(:review).permit(:user_review, :rating, :video_id, :user_id)
    end
end