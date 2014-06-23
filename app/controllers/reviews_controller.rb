class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.build(review_params.merge!(user: current_user))

    if review.save
      redirect_to video_path(@video)
    else
      # .reload will pull only the reviews in the db in order to ignore the invalid review that the user just created
      @reviews = @video.reviews.reload
      render 'videos/show'
    end  
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end