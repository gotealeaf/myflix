class ReviewsController < ApplicationController
  before_action :current_user

  def create
    #binding.pry
    @video = Video.find_by(params[:id])
    @review = @video.reviews.create(review_params.merge!(user: current_user, video_id: @video))

    redirect_to video_path(@video)
  end

  private 

    def review_params
      params.require(:review).permit(:user_review, :rating, :video, :user)
    end
end