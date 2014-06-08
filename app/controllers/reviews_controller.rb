class ReviewsController < ApplicationController
  before_action :require_user
  
  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      flash[:success] = "Your review was added."
      redirect_to video_path(@video)
    else
      flash[:danger] = "Your review could not be saved at this time."
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end
  
  def review_params
    params.require(:review).permit(:content, :rating)
  end
  
end