class ReviewsController < ApplicationController
	before_filter :require_user
  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params.merge!(user: current_user))
   
    if @review.save
    	redirect_to @video
    else
     	@reviews = @video.reviews.reload
    	render 'videos/show'
    end
  end

private
  def review_params
     params.require(:review).permit(:user_id, :video_id, :content, :rating)
  end

end
