class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)


    render 'videos/show'

    if @review.save
      flash[:success] = "Your review has been added."
    else
      flash[:danger] = "Sorry, your review wasnt added."
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

end
