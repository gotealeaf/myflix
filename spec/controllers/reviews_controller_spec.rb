require 'spec_helper'

describe ReviewsController do 
  describe "POST create" do
    context "user authenticated" do
      context "review valid" do
        before do
          session[:user_id] = Fabricate(:user).id
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it "creates a new review" do
          expect(assigns(:review)).to be_instance_of(Review)
          expect(assigns(:review)).to be_valid
          expect(assigns(:review).save).to be_true
          expect(Review.count).to eq(1)
        end

        it "sets a success message" do
          expect(flash[:success]).not_to be_blank
        end

        it "redirects to the show video page" do
          expect(response).to redirect_to video_path(Video.first)
        end
      end
      context "review not valid" do
        before do
          session[:user_id] = Fabricate(:user).id
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review, review_text: ""), video_id: video.id
        end
        it "does not create a new review" do
          expect(assigns(:review)).to be_instance_of(Review)
          expect(assigns(:review)).not_to be_valid
          expect(assigns(:review).save).not_to be_true
          expect(Review.count).to eq(0)
        end
        it "sets an error message" do
         expect(flash[:danger]).not_to be_blank
        end
        it "renders the video show page" do
          expect(response).to render_template 'videos/show'
        end
      end
      context "user has already submitted a review" do
        before do
          session[:user_id] = Fabricate(:user).id
          video = Fabricate(:video)
          Fabricate(:review, video_id: video.id, user_id: session[:user_id])
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id, user_id: session[:user_id]
        end
        it "does not create a new review" do
          expect(assigns(:review)).to be_instance_of(Review)
          expect(assigns(:review)).not_to be_valid
          expect(assigns(:review).save).not_to be_true
          expect(Review.count).to eq(1)
        end
        it "sets a special error message" do
          expect(flash[:danger]).not_to be_blank
          expect(flash[:danger]).to eq("Sorry, you can only review a video once.")
        end
        it "renders the video show page" do
          expect(response).to render_template 'videos/show'
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

      it "sets a special error message" do
        expect(flash[:danger]).not_to be_blank
        expect(flash[:danger]).to eq("You must be logged in to do that.")
      end

      it "redirects to login path" do
        expect(response).to redirect_to login_path
      end
    end
  end
end