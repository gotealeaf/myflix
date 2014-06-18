class ReviewsController < ApplicationController
  before_filter :require_user
  
  def create
    @video = Video.find(params[:video_id])
    # create review using strong params and associate with video
    # note the merge syntax with current_user to associate
    review = @video.reviews.build(review_params.merge!(user: current_user))
    if review.save
      redirect_to @video
    else
      # reload syntax reloads from DB, invalid review in memory is then ignored
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :video_id, :rating, :content)
  end
end
