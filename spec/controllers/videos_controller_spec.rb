require 'spec_helper'

describe VideosController do

  describe 'GET show' do
    let!(:video) {Fabricate(:video)}

    it_behaves_like "requires sign in" do
      let(:action) {get :show, id: video.id}
    end

    context "for authenticated users" do 
      before {session[:user_id] = Fabricate(:user).id}

      it "sets the video id " do     
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
      it "sets the @reviews variable" do
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        get :show, id: video.id
        assigns(:reviews).should match_array([review1, review2])
      end
    end
  end

  describe 'POST search' do

    it_behaves_like "requires sign in" do
      let(:action) {post :search, search_term: 'rama'}
    end
    it "sets the results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end
  end
end
