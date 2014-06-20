require "spec_helper"

describe VideosController do
  describe "GET show" do
    before { @video = Fabricate(:video) }

    context "with authenticated user" do
      before do
        session[:user_id] = Fabricate(:user).id
        get :show, id: @video.id
      end

      it "assigns @video" do
        expect(assigns(:video)).to eq(@video)
      end
      
      it "assigns @review" do
        expect(assigns(:review)).to be_a(Review)
      end
    end

    context "without authenticated user" do
      it "redirects to login page" do
        get :show, id: @video.id
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST search" do
    it "assigns @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      breaking_bad = Fabricate(:video, title: "Breaking Bad")
      post :search, search: "break"
      expect(assigns(:videos)).to eq([breaking_bad])
    end

    it "redirects unauthenticated users login page" do
      breaking_bad = Fabricate(:video, title: "Breaking Bad")
      post :search, search: "break"
      expect(response).to redirect_to login_path
    end
  end
end