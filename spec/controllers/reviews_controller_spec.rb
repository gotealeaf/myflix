require "spec_helper"

describe ReviewsController do
  describe "POST create" do
    context "with authenticated user" do
      let(:video) { Fabricate(:video) }
      before do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
      end

      context "with valid input" do
        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: @video.id
        end

        it "saves a new review to the database" do
          expect(Review.count).to eq(4)
        end

        it "creates a review associated with the video" do
          expect(Review.find(4).video).to eq(@video)
        end

        it "creates a review associated with logged in user" do
          expect(Review.find(4).creator).to eq(@user)
        end

        it "sends notice" do
          expect(flash[:notice]).to_not be_blank
        end 

        it "redirects to videos/show page" do
          expect(response).to redirect_to video_path(@video)
        end
      end

      context "with invalid input" do
        before do
           post :create, review: { rating: 4 }, video_id: @video.id
        end

        it "does not save a new video to database" do
          expect(Review.count).to eq(3)
        end

        it "renders videos/show template" do
          expect(response).to render_template "videos/show"
        end
      end
    end
  end

  context "with unauthenticated user" do
    it "redirects to login page" do
      post :create, review: Fabricate.attributes_for(:review), video_id: @video.id
      expect(response).to redirect_to login_path
    end
  end
end









