class ReviewsController < ApplicationController
  def create
    video = Video.find(params[:video_id])
    Review.create(params[:review])
    redirect_to video
  end
end
