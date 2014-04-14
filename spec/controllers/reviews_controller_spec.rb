require 'spec_helper'

describe ReviewsController do 
  describe "POST create" do
    context "user authenticated" do
      before(:each) do
        user = Fabricate(:user)
        session[:user_id] = user.id
      end

      context "review valid" do
        before do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it "creates a new review" do
          expect(assigns(:review)).to be_instance_of(Review)
          expect(assigns(:review)).to be_valid
          expect(assigns(:review).save).to be_true
          expect(Review.count).to eq(1)
        end

        it "creates a new review associated with the creator" do
          expect(Review.first.creator).to eq(User.first)
        end

        it "creates a new review associated with the video" do
          expect(Review.first.video).to eq(Video.first)
        end

        it "sets a success message" do
          expect(flash[:success]).not_to be_blank
        end

        it "redirects to the show video page" do
          expect(response).to redirect_to video_path(Video.first)
        end
      end

      context "review not valid" do
        before(:each) do
          video = Fabricate(:video)
        end

        it "does not create a new review" do
          post :create, review: Fabricate.attributes_for(:review, review_text: ""), video_id: Video.first.id
          expect(assigns(:review)).to be_instance_of(Review)
          expect(assigns(:review)).not_to be_valid
          expect(assigns(:review).save).not_to be_true
          expect(Review.count).to eq(0)
        end

        it "sets an error message" do
          post :create, review: Fabricate.attributes_for(:review, review_text: ""), video_id: Video.first.id
          expect(flash[:danger]).not_to be_blank
        end

        it "sets @video" do
          post :create, review: Fabricate.attributes_for(:review, review_text: ""), video_id: Video.first.id
          expect(assigns(:video)).to eq(Video.first)
        end

        it "sets @reviews" do
          review = Fabricate(:review, video_id: Video.first.id)
          post :create, review: Fabricate.attributes_for(:review, review_text: ""), video_id: Video.first.id
          expect(assigns(:reviews)).to eq([review])
        end

        it "renders the video show page" do
          post :create, review: Fabricate.attributes_for(:review, review_text: ""), video_id: Video.first.id
          expect(response).to render_template 'videos/show'
        end
      end

      context "user has already submitted a review" do
        before do
          video = Fabricate(:video)
          review = Fabricate(:review, video_id: video.id, user_id: session[:user_id])
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it "does not create a new review" do
          expect(assigns(:review)).to be_instance_of(Review)
          expect(assigns(:review)).not_to be_valid
          expect(assigns(:review).save).not_to be_true
          expect(Review.count).to eq(1)
        end

        it "renders the video show page" do
          expect(response).to render_template 'videos/show'
        end

        it "sets @video" do
          post :create, review: Fabricate.attributes_for(:review, review_text: ""), video_id: Video.first.id
          expect(assigns(:video)).to eq(Video.first)
        end

        it "sets @reviews" do
          post :create, review: Fabricate.attributes_for(:review, review_text: ""), video_id: Video.first.id
          expect(assigns(:reviews)).to eq([Review.first])
        end
      end     
    end

    context "user not authenticated" do
      before do
        video = Fabricate(:video)
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
      end

      it "does not create a new review" do
        expect(Review.count).to eq(0)
      end

      it "sets a special error message telling user to login" do
        expect(flash[:danger]).not_to be_blank
        expect(flash[:danger]).to eq("You must be logged in to do that.")
      end

      it "redirects to login path" do
        expect(response).to redirect_to login_path
      end
    end
  end
end