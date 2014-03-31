class ReviewsController < ApplicationController


  def create
    require_user
    if logged_in?
      @review = Review.new(review_params)
      @video = @review.video

      if @review.save
        redirect_to video_path(@video)
      else
        @user = User.find(session[:user_id])
        @reviews = @video.reviews
        if @reviews.count > 0
          @avg_rating = @reviews.average(:rating).round(1)
        else
          @avg_rating = 3
        end
        render 'videos/show', assigns: { video: @video }
      end
    end
  end

  private

  def review_params 
    params.require(:review).permit(:content, :rating, :video_id, :user_id)
  end
end