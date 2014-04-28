class ReviewsController < ApplicationController

  before_action :require_user, only: [:create]

  def create
    video = Video.find(params[:video_id])
    @review = Review.new(review_params)
    if @review.save
      redirect_to video
    else
      flash[:error] = "Can not rating twice !!"
      redirect_to video
    end
  end

  def update
    
  end

  private

  def review_params
    params.require(:review).permit(:rating, :review_description).merge(user_id: current_user.id, video_id: params[:video_id])
  end
end
