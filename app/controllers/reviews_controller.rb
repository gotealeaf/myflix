class ReviewsController < ApplicationController
  def create
    video = Video.find(params[:video_id])
    review = video.reviews.build(params.require(:review).permit(:content, :rating).merge!( user: current_user))
    if review.save
      redirect_to video
    else
      render 'videos/show'
    end
  end
end