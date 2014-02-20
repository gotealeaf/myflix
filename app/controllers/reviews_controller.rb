class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find_by id: session[:video_id]
    @review = Review.new(review_params)
    @review.video = @video
    @review.user = User.find_by id: session[:user_id]
    binding.pry
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
    params.require(:review).permit(:rating, :content)
  end

end
