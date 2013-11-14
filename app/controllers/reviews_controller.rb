class ReviewsController < ApplicationController

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.new(review_params.merge(user_id: current_user.id ))
    if review.save
      redirect_to video_path(@video)
    else 
      @reviews = @video.reviews.reload
      render "videos/show"
    end
  end

  private
    def review_params
      params.require(:review).permit(:content, :rating)
    end
end