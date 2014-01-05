require 'spec_helper'

describe VideosController do
	describe "GET show" do 
    it "sets the @video for authenticated users" do
    	session[:user_id] = Fabricate(:user).id
    	video = Fabricate(:video)
    	get :show, id: video.id
    	expect(assigns(:video)).to eq(video)
    end
    it "redirects unauthenticated users to the sign in page" do
    	video = Fabricate(:video)
    	get :show, id: video.id
    	expect(response).to redirect_to sign_in_path
	  end
	end
	describe "POST search" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end
    it "redirects unauthenticated users to the sign in page" do
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'
      expect(response).to redirect_to sign_in_path
    end
	end
end