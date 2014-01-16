require 'spec_helper'

describe VideosController do

  describe "GET show" do
  	context "with authenticated users" do
  		before do
  			session[:user_id] = Fabricate(:user).id
  		end

		  it "sets the @video variable" do
		    video = Fabricate(:video)
		    get :show, id: video.id
		    expect(assigns(:video)).to eq(video)
		  end

		  it "renders the show template" do
		    video = Fabricate(:video)
		    get :show, id: video.id
		    expect(response).to render_template :show
		  end
		end

		context "with unauthenticated users" do
			it "redirects the user to the sign_in page" do
				video = Fabricate(:video)
		    get :show, id: video.id
		    expect(response).to redirect_to sign_in_path
		  end
		end
  end

  describe "POST search" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      lost = Fabricate(:video, title: 'Lost Highway')
      post :search, search_term: 'Highway'
      expect(assigns(:results)).to eq([lost])
    end

    it "redirects to sign_in page for unauthenticated users" do
      lost = Fabricate(:video, title: 'Lost Highway')
      post :search, search_term: 'Highway'
      expect(response).to redirect_to sign_in_path
    end
  end
end
