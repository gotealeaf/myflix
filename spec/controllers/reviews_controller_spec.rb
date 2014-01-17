require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video) { Fabricate(:video) }
    context "with unauthenticated users" do 
      it "redirect to the sign in page" do
        post :create
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with authenticated users" do
      let(:current_user) {Fabricate(:user)}
      before { session[:usesr_id] = current_user.id }

      context "with valid inputs" do
        before { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }

        it "redirect to the video show page" do
          expect(response).to redirect_to video 
        end

        it "creates a review" do
          expect(Review.count).to eq(1) 
        end
       
        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end

        it "creates a review associated with the user" do
          expect(Review.first.user).to eq(current_user)
        end
      end

      context "with invalid inputs" do
        before { post :create, review: {rate: 5}, video_id: video.id }

        it "sets the error message" do
          expect(flash[:error]).not_to be_blank
        end

        it "renders the show page again" do
          expect(response).to render_template 'videos/show'
        end
      end
    end
  end
end
