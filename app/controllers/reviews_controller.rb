class ReviewsController < ApplicationController
  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_param)
    @review.user = current_user

    if @review.save
      flash[:notice] = 'Your review has been submitted.'
      redirect_to video_path(@video)
    else
      render 'videos/show'
    end
  end

  def review_param
    params.require(:review).permit(:body, :rating)
  end
end