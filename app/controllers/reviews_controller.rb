class ReviewsController < ApplicationController
  before_action :signed_in_user

  def create
    @video = Video.find_by(token: params[:video_id])
    @review = current_user.reviews.new(review_params)
    @review.video = @video
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
      params.require(:review).permit(:rating, :content, :video)
    end
end
