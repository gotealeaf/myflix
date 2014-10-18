require 'spec_helper'

describe ReviewsController do
	describe "POST create" do
		context "Valid review" do
			it "should create a review" do
				session[:user_id] = "1"
				video = Video.create(title:"test", description:"testtest")
				post :create, review: Fabricate.attributes_for(:review), video_id: video.id
				expect(Review.count).to eq(1)
			end

			it "should createa review with video_id" do
				session[:user_id] = "1"
				video = Fabricate(:video)
				post :create, review: Fabricate.attributes_for(:review), video_id: video.id
				expect(Review.first.video).to eq(video)
			end

			it "should create a review with user_id" do
				session[:user_id] = "1"
				video = Fabricate(:video)
				post :create, review: Fabricate.attributes_for(:review), video_id: video.id
				expect(Review.first.user.id).to eq(1)
			end


			it "should redirect_to videos_path" do
				session[:user_id] = "1"
				video = Fabricate(:video)
				post :create, review: Fabricate.attributes_for(:review), video_id: video.id
				expect(response).to redirect_to videos_path
			end
		end

		context "Invaid review/failed validations" do
			it "should not create a review" do
				session[:user_id] = "1"
				video = Fabricate(:video)
				post :create, review: {body: "test review"} , video_id: video.id
				expect(Review.count).to eq(0)
			end

			it "should update flash[:Error]" do
				session[:user_id] = "1"
				video = Fabricate(:video)
				post :create, review: {body: "test review"}, video_id: video.id
				expect(flash[:error]).not_to be_blank
			end

			it "should redirect_to videoes_path" do
				session[:user_id] = "1"
				video = Fabricate(:video)
				post :create, review: {body: "test review"}, video_id: video.id
				expect(response).to redirect_to videos_path
			end

		end

		context "not authenticated" do
			it 'should redirect to home page' do
				video = Fabricate(:video)
				post :create, review: Fabricate.attributes_for(:review), video_id: video.id
				expect(response).to redirect_to root_path
			end
		end
	end
end

		


=begin
	def create
		@review = Review.new(reviewparams)
		@review.update(user_id: current_user.id, video_id: params[:id])
	
		if @review.save
			flash[:notice] = "Your review has been saved!"
			redirect_to :back
		else
			flash[:error] = "There was something wrong with your review"
			redirect_to :back
		end 
	end

	private
	def reviewparams
		params.require(:review).permit!
	end

end
=end