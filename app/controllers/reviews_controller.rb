class ReviewsController < ApplicationController

  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = Review.new(review_params.merge!(user: current_user, video: @video))
    if @review.save
      flash[:success] = "Thanks! Your review has been posted!"
      redirect_to video_path(@video)
    else
      # Todo: Add error message.
      @reviews = @video.reviews
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit!
  end
end
