require 'spec_helper'

describe VideosController do
  describe 'GET show' do
    

      it "sets the video id for auathenticated users" do
        # user = User.create(full_name: "Bob", email: 'bob@bob.bob', password: 'password')
        # session[:user_id] = user.id
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
          # video = Video.create(title: 'up', description: 'good')
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
  
      it "redirects to sign_in for unathenticated users" do
        video = Fabricate(:video)
        # video = Video.create(title: 'up', description: 'good')
        get :show, id: video.id
        expect(response).to redirect_to sign_in_path

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
