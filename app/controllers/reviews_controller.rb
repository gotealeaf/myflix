class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "Review successfully"
      render :back
    else
      flash[:error] = "Miss something"
      render :back
    end
  end

  private
  def review_params
    params.require(:review).permit!
  end
end
