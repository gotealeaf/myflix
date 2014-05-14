require 'spec_helper'

describe VideosController do
  
  describe "GET Show" do 
    let(:video) { Fabricate(:video) }
    
    context "with authenticated users" do
      before do
        set_current_user
      end
      
      it "should set the @video instance variable" do
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
      
      it "should set the @review instance variable" do
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        get :show, id: video.id
        expect(assigns(:reviews)).to  match_array([review1, review2])
      end
      
      it "should render the show page" do
        get :show, id: video.id
        expect(response).to render_template :show
      end
    end # ends the authenticated users context test spec
    
    context "with unauthenticated users" do
      it "redirects users to the main home page" do
        get :show, id: video.id
        expect(response).to redirect_to root_path
      end
    end #ends unauthenticated users context    
  end # ends the GET Show action test spec
  
  describe "GET Search" do
    context "with authenticated users" do
      before do
        set_current_user
      end
    
      it "should set the @results instance variable" do
        futurama = Fabricate(:video, title: "Futurama")
        get :search, title: 'rama'
        expect(assigns(:results)).to eq([futurama])
      end
        
      it "should render the search page" do
        futurama = Fabricate(:video, title: "Futurama")
        get :search, title: 'rama'
        expect(response).to render_template :search
      end
    end # ends the context for authenticated users
    
    context "with unauthenticated users" do
      
      it_behaves_like 'require sign in' do
        let(:action) { get :search }
      end
    end #ends context of unauthenticated users  
    
  end #ends the GET search test spec
end #ends the videos controller test