class ReviewsController < ApplicationController
  before_filter :require_user
  
  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.create(params[:review].merge!(user: current_user))
    if review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end
end
##