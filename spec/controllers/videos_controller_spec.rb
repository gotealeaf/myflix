require 'spec_helper'

describe VideosController do
  describe 'GET show' do

    it "redirects to sign_in for unathenticated users" do
      video = Fabricate(:video)
      # video = Video.create(title: 'up', description: 'good')
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end

    context "for authenticated users" do
      let(:test_video) { Fabricate(:video) }
      before do
         session[:user_id] = Fabricate(:user).id
          get :show, id: test_video.id
      end

      it "sets the video id for auathenticated users" do     
        # video = Fabricate(:video)
        expect(assigns(:video)).to eq(test_video)
      end
      it "sets the @reviews variable" do
        review1 = Fabricate(:review, video: test_video)
        review2 = Fabricate(:review, video: test_video)
        assigns(:reviews).should match_array([review1, review2])
      end
    end
  end

      describe 'POST search' do
        it "sets the results for authenticated users" do
          session[:user_id] = Fabricate(:user).id
          futurama = Fabricate(:video, title: 'Futurama')
          post :search, search_term: 'rama'
          expect(assigns(:results)).to eq([futurama])
        end

        it "redirects unauthenticated users to the sign_in page" do
          futurama = Fabricate(:video, title: 'Futurama')
          post :search, search_term: 'rama'
          expect(response).to redirect_to sign_in_path
        end 
      end


end
