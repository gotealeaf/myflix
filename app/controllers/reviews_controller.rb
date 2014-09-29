class ReviewsController < ApplicationController

  before_filter :logged_in?

  def create
    video = Video.find_by_id(params[:video_id])
    @review = video.reviews.build(review_params.merge!({user: current_user}))
    if @review.save
       flash[:notice] = "Review has been saved"
     else
       flash[:error] = "Review cannot be saved. Please enter all required fields"
    end
    redirect_to video
  end

  private

    def review_params
      params.require(:review).permit(:rating, :description, :user_id, :video_id)
    end
end
