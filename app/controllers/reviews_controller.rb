class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.new(review_params)
    @review.creator = current_user

    if @review.save
      flash[:success] = 'Your review has been submitted successfully.'
      redirect_to video_path(@video)
    else
      flash.now[:danger] = 'Your review was not submitted successfully, please try again.'
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
