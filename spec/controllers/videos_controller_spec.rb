require "spec_helper"

describe VideosController do
  describe "GET show" do
    let(:video)  { Fabricate(:video) }

    context "with authenticated user" do
      before do
        session[:user_id] = Fabricate(:user).id
        get :show, id: video.id
      end

      it "assigns @video" do
        expect(assigns(:video)).to eq(video)
      end
      
      it "assigns @review" do
        expect(assigns(:review)).to be_a(Review)
      end
    end

    it_behaves_like "require_login" do
      let(:action) { get :show, id: video.id }
    end
  end

  describe "POST search" do
    let(:breaking_bad) { Fabricate(:video, title: "Breaking Bad") }

    it "assigns @video for authenticated users" do
      set_current_user
      post :search, search: "break"
      expect(assigns(:videos)).to eq([breaking_bad])
    end

    it_behaves_like "require_login" do
      let(:action) { post :search, search: "break" }
    end
  end
end