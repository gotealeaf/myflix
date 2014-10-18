class ReviewsController < ApplicationController
	before_action :require_user
	def create
		
		@review = Review.new(reviewparams.merge!(video_id: params[:video_id], user_id: session[:user_id]))
		#@review.update(user_id: current_user.id, video_id: params[:id])
	
		if @review.save
			flash[:notice] = "Your review has been saved!"
			redirect_to videos_path
		else
			flash[:error] = "There was something wrong with your review"
			redirect_to videos_path
		end 
	end

	private
	def reviewparams
		params.require(:review).permit!
	end
end