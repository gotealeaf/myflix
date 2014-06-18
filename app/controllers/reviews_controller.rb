class ReviewsController < ApplicationController
  before_filter :authorize
  before_filter :find_video

  def create
    @new_review = Review.new(review_params.merge({video: @video, user: current_user}))
    if @new_review.save
      flash[:success] = "Thanks for reviewing this video!"
      redirect_to video_path(@video)
    else
      flash.now[:error] = "There was an error submitting your review."
      render 'videos/show'
    end
  end

  private

  def find_video
    @video = Video.find(params[:video_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end

end
