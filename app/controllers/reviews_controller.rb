class ReviewsController < ApplicationController
  before_action :require_user
  
  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(params.require(:review).permit(:content, :rating))
    @review.user = current_user
    if @review.save
      flash[:success] = "Your review was added."
      redirect_to video_path(@video)
    else
      flash[:danger] = "Your review could not be saved at this time."
      render 'videos/show'
    end
  end
  
end