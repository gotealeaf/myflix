class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.new(review_params)
    @review.creator = current_user
    
    if @review.save
      flash[:notice] = "Review saved!"
      redirect_to video_path(@video)
    else
      @video.reviews.reload
      render "videos/show"
    end
  end
end

private

def review_params
  params.require(:review).permit(:body, :rating)
end