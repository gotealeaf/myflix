class ReviewsController < ApplicationController

  before_filter :logged_in?

  def create
    @review = Review.new(review_params)
    @video = Video.find_by_id(params[:review][:video_id])
    redirect_to video_path(@video.id)
  end

  private

    def review_params
      params.require(:review).permit(:rating, :description, :user_id, :video_id)
    end
end
