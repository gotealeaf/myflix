class ReviewsController < ApplicationController

  def create
    @video = Video.find(params[:id])
    @review = Review.new(
      rating: params[:rating],
      review_description: params[:review_description],
      video: @video,
      user: current_user
    )
    if @review.save
      redirect_to "videos#show"
    else
      flash[:error] = "Can not rating twice !!"
      redirect_to "videos#show"
    end
  end

end
