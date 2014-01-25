require 'spec_helper'

describe VideosController do
  describe "Get show" do
    
    let(:video) { Fabricate(:video) }
    
    it "sets @video when logged in" do
      set_current_user
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    
    it "sets @reviews for authenticated users" do
      set_current_user
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end
    
    it "redirects the user to the sign-in page if not authenticated" do
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end
  
  describe "Post search" do
    
    let(:futurama) { Fabricate(:video, name: "Futurama")}
    
    it "sets @results for authenticated users" do
      set_current_user
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end
    it "redirects the user to the sign-in page if not authenticated" do
       post :search, search_term: 'rama'
      expect(response).to redirect_to sign_in_path
    end
  end
end
