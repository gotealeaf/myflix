class ReviewsController < ApplicationController
  before_action :require_signed_in, only: [:create]

  def create
    @video  = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params.merge!(user: current_user))

    if @review.save
      flash[:notice] = "Review posted."
    else
      #THIS ISN"T QUITE CORRECT IF USER TRIES TO SEND OTHER RATING
      # WOULD BE BEST TO HANDLE THE ERRORS SEPARATELY
      flash[:error] = "You can only review a video once."
    end
      redirect_to @video
  end

  private
    def review_params
      params.require(:review).permit(:rating, :content)
    end
end
