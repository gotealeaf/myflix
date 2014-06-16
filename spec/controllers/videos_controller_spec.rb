require 'rails_helper.rb'

describe VideosController do
  let(:video) { Fabricate(:video) }
  let(:user) { Fabricate(:user) }

# using contexts but not necessary here
  describe "GET show" do
    context "authenticated users" do
      before do
        session[:user_id] = user.id
      end

      it "sets @video" do
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end

      # not necessary, built into rails, but example of how to do
      it "renders the show template" do
        get :show, id: video.id
        expect(response).to render_template :show
      end
    end

    context "unauthenticated users" do
      it "redirects to sign in" do
        get :show, id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "POST search" do
    it "sets @results if user is authenticated" do
      session[:user_id] = user.id
      post :search, search_term: video.title
      expect(assigns(:results)).to eq([video])
    end

    it "redirects to sign in if user is unauthenticated" do
      post :search, search_term: video.title
      expect(assigns(:results)).to redirect_to sign_in_path
    end
  end
end
