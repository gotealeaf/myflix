require 'spec_helper'

describe VideosController do
  describe "GET index" do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "sets the @videos variable" do
        kungfu = Video.create(title: "Kung Fu", description: "Jack Chen") 
        kungfu_panda = Video.create(title: "Kung Fu Panda", description: "Bao") 
        get :index
        assigns(:videos).should == [kungfu, kungfu_panda]
      end

      it "renders the index template" do
        get :index 
        response.should render_template :index
      end
    end
  end

  describe "GET show" do
    let(:video) { Fabricate(:video) }
    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets the @reviews variable" do
      session[:user_id] = Fabricate(:user).id
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "renders the show template" do
      session[:user_id] = Fabricate(:user).id
      get :show, id: video.id
      expect(response).to render_template :show
    end

    it "redirects the user to the sign in page for unauthenticated users" do
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path 
    end
  end

  describe "POST search" do
    it "sets @results for authenticatited users" do
      session[:user_id] = Fabricate(:user).id
      kungfu = Fabricate(:video, title: "Kung Fu")
      post :search, search_term: 'Fu'
      expect(assigns(:results)).to eq([kungfu])
    end

    it "redirects the user to the sign in page for unauthenticated" do
      kungfu = Fabricate(:video, title: "Kung Fu")
      post :search, search_term: 'Fu'
      expect(response).to redirect_to sign_in_path 
    end
  end
end
