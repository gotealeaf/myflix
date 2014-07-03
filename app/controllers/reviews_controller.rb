class ReviewsController < ApplicationController
  before_filter :authorize
  before_filter :find_video

  def create
    @review = @video.reviews.build(review_params.merge!({user: current_user,complete_review:true}))
    if @review.save
      flash[:success] = "Thanks for reviewing this video!"
      redirect_to video_path(@video)
    else
      @reviews = @video.reviews.reload
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
