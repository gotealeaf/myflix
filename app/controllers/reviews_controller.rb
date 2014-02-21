class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find_by id: params[:video_id]
    @review = Review.new(review_params)
    @review[:video_id] = @video.id
    @review[:user_id] = session[:user_id]
    if @review.save
      flash[:success] = "Your review has been added."
      redirect_to :back
    else
      flash[:danger] = "Sorry, your review wasnt added."
      redirect_to :back
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :user_id, :video_id)
  end

end
