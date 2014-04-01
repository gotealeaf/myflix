require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }

    context "with unauthenticated users" do
      it "redirects to the sign_in_path" do
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(response).to redirect_to(sign_in_path)
      end

      it "does not set @review" do
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(assigns(:review)).to be_nil
      end
    end

    context "with authenticated users" do
      it "sets @average_rating if no reviews with invalid data" do
        session[:user_id] = user
        post :create, review: Fabricate.attributes_for(:review, content: nil), video_id: video.id
        expect(assigns(:average_rating)).to eq("Not yet reviewed.")
      end

      context "with invalid data" do
        before :each do
          session[:user_id] = user
          @review_1 = Fabricate(:review, user: user, video: video, rating: 3)
          @review_2 = Fabricate(:review, user: user, video: video, rating: 3)
          @review_3 = Fabricate(:review, user: user, video: video, rating: 4)
          post :create, review: Fabricate.attributes_for(:review, content: nil), video_id: video.id
        end

        it "sets @video" do
          expect(assigns(:video)).to eq(video)
        end

        it "raises errors on @review" do
          expect(assigns(:review)).to have(1).error_on(:content)
        end

        it "does not save review" do
          expect(Review.count).to eq(3)
        end

        it "sets @reviews" do
          expect(assigns(:reviews)).to match_array([@review_1, @review_2, @review_3])
        end

        it "sets @average_rating rounded 1 place" do
          expect(assigns(:average_rating)).to eq(3.3)
        end

        it "renders to videos/show" do
          expect(response).to render_template('videos/show')
        end
      end

      context "with valid data" do
        before :each do
          session[:user_id] = user
          @video = video
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it "saves the review" do
          expect(Review.first).to be_instance_of(Review)
        end

        it "sets @review.video" do
          expect(assigns(:video)).to eq(@video)
        end

        it "redirects to video_path" do
          expect(response).to redirect_to(video_path(@video.id))
        end
      end
    end
  end
end