class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(params.require(:review).permit(:body))
    @review.user = current_user

    if @review.save
      flash[:notice] = "Your review was created."
      redirect_to video_path(@video)
    else
      render 'videos/show'
    end
  end

  private
  
  def comment_params
    params.require(:review).permit!
  end

end