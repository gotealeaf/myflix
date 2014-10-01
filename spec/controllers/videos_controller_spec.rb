require 'spec_helper'

describe VideosController do 

  describe "GET show" do
    it "should set the video instance variable" do
      set_current_user
      video = Fabricate(:video)
      get :show, id: video.id 
      assigns(:video).should == video
    end

    it "should set the @review variable" do
      set_current_user
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      assigns(:reviews).should =~ [review1, review2]
    end

    it "should render the sign in page if not logged in" do
      video = Fabricate(:video)
      get :show, id: video.id
      response.should redirect_to sign_in_path
    end

    it "should render the show page if logged in" do
      set_current_user
      video = Fabricate(:video)
      get :show, id: video.id
      response.should render_template :show
    end
  end

  describe "GET search" do
    it "sets @results for authenticated users" do
      set_current_user
      futurama = Fabricate(:video, title: 'Futurama')
      get :search, {'search' => {'term' => 'rama'}}
      assigns(:results).should == [futurama]
    end

    it_behaves_like "require_sign_in" do 
      let(:action) { get :search, {'search' => {'term' => 'rama'}} }
    end
  end
end