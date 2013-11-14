class ReviewsController < ApplicationController
  before_action :require_user
  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.new(review_params)
    if review.save
      binding.pry
      redirect_to video_path(@video)
    else 
      @reviews = @video.reviews.reload
      render "videos/show"
    end
  end

  private
    def review_params
      params.require(:review).permit(:video_id, :user_id, :content, :rating)
    end
end