class ReviewsController < ApplicationController
  before_action :require_signed_in, only: [:create]

  def create
    @video = Video.find(params[:video_id])
    #binding.pry
    @review = @video.reviews.build(review_params.merge!(user: current_user))
    if @review.save
      flash[:notice] = "Review posted."
      redirect_to @video
    else
      #flash[:error] = "Invalid. Review not posted."
      render 'videos/show'
    end
  end

  private
    def review_params
      params.require(:review).permit(:rating, :content)
    end
end
