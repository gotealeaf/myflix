require 'spec_helper'

describe VideosController do 

  describe "GET show" do
    it "should set the video instance variable" do
      video = Fabricate(:video)
      get :show, id: video.id 
      assigns(:video).should == video
    end

    it "should render the sign in page if not logged in" do
      video = Fabricate(:video)
      get :show, id: video.id
      response.should redirect_to sign_in_path
    end

    it "should render the show page if logged in" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      response.should render_template :show
    end
  end

  describe "GET search" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama')
      get :search, {'search' => {'term' => 'rama'}}
      assigns(:results).should == [futurama]
    end
    it "redirects to sign in page for unathenticated users" do
      futurama = Fabricate(:video, title: 'Futurama')
      get :search, {'search' => {'term' => 'rama'}}
      assigns(:results).should redirect_to sign_in_path
    end
  end
end