class ReviewsController < AuthenticatedController
  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params.merge!(creator: current_user))
    if @review.save
      flash[:success] = "Thanks for the review, #{current_user.full_name}!"
      redirect_to video_path(@video)
    else
      flash[:danger] = "Review could not be saved."
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :review_text, :video_id)
  end
end