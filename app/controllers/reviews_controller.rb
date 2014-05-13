class ReviewsController < ApplicationController
  before_action :current_user, :authorize

  def create
    
    @video = Video.find(params[:video_id])
    review = @video.reviews.create(review_params.merge!(user: current_user, video_id: @video.id))

    if review.save
      redirect_to video_path(@video)
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private 

    def review_params
      params.require(:review).permit(:content, :rating, :video_id, :user_id)
    end

end