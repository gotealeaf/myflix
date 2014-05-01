require 'spec_helper'

describe VideosController do
  #let(:video) { Video.create(name: "futurama", description: "funny movie", id: 1) } alternative
  
  describe "GET Show" do   
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      
      it "should set the @video instance variable" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
      
      it "should render the show page" do
        video = Fabricate(:video)
        get :show, id: video.id
        response.should render_template :show
      end 
    end # ends the authenticated users test spec
    
    context "with unauthenticated users" do
      it "redirects users to the main home page" do
        video = Fabricate(:video)
        get :show, id: video.id
        response.should redirect_to root_path
      end
    end     
  end # ends the GET Show action test spec
  
  describe "GET Search" do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
    
      it "should set the @results instance variable" do
        futurama = Fabricate(:video, title: "Futurama")
        get :search, title: 'rama'
        expect(assigns(:results)).to eq([futurama])
      end
        
      it "should render the search page" do
        futurama = Fabricate(:video, title: "Futurama")
        get :search, title: 'rama'
        response.should render_template :search
      end
    end # ends the context for authenticated users
    
    context "with unauthenticated users" do
      it "should redirect the user to the main home page" do
        get :search
        response.should redirect_to root_path
      end
    end # ends the GET Search unauthenticated users test spec 
  end #ends the GET search test spec
 end #ends the videos controller test