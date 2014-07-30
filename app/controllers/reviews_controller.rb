class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(params.require(:review).permit(:body))

  end

  private
  
  def comment_params
    params.require(:review).permit!
  end

end