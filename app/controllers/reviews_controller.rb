class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      flash[:notice] = "Your review was created."
      redirect_to video_path(@video)
    else
      flash[:error] = "You must contribute review content in order to post."     
      render 'videos/show'
    end
  end

  private
  
  def review_params
    params.require(:review).permit(:rating, :content)
  end

end