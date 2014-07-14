require 'rails_helper'

describe VideosController do

  describe "GET show" do
    before { set_current_user }
    let(:video) { Fabricate(:video) }

    it "sets @video if user is signed in" do
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    
    it "sets @reviews for signed in users" do
      review1 = Fabricate(:review, video: video, user: current_user)
      review2 = Fabricate(:review, video: video, user: current_user)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1,review2])
    end
    
    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: video.id }
    end

  end

  describe "GET search" do
    it "sets @videos if user signed in" do
      set_current_user
      batman = Fabricate(:video, title: "Batman")
      get :search, search_term: 'bat'
      expect(assigns(:videos)).to eq([batman])
    end
    
    it_behaves_like "require_sign_in" do
      Fabricate(:video, title: "Superman")
      let(:action) { get :search, search_term: 'man' }
    end

  end
  

end
