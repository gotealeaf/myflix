class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.new(review_params)
    @review.user = current_user
    
    if @review.valid?
      @review.save
      flash[:success] = "Your review was saved."
      redirect_to video_path(@video)
    else
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :text)
  end

end