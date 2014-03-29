class ReviewsController < ApplicationController
  before_action :require_user
  def create
    @video = Video.find_by(id: params[:video_id])
    @review = @video.reviews.new(review_params.merge!(user: current_user))
    if @review.save
      redirect_to video_path(@video)
    else
      @video.reload
      @reviews = @video.reviews
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
