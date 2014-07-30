require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    it "sets @video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
      expect(assigns(:video)).to eq(video)
    end

    it "sets @review" do
    end

    it "sets @review.user to the current user" do
    end

    context "if review attributes are valid" do
      it "creates a new review" do
      end

      it "sets the flash notice" do
      end

      it "redirects to the video path" do
      end
    end
    context "if review attributes are not valid" do
      it "does not create a new review" do
      end

      it "renders videos/show" do
      end
    end
  end
end