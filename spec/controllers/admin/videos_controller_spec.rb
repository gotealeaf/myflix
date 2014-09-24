require 'spec_helper'

describe Admin::VideosController do 
  describe "GET new" do 
    it_behaves_like "require_sign_in"  do 
      let(:action) { get :new }
    end
    it "sets @video to a new video" do
      set_current_user_as_admin
      get :new
      assigns(:video).should be_instance_of Video
      assigns(:video).should be_new_record 
    end
    it "redirects to home path if not admin" do 
      set_current_user 
      get :new
      response.should redirect_to home_path
    end
    it "sets the flash error message if not admin" do
      set_current_user
      get :new
      flash[:error].should be_present
    end

  end

  describe "POST create" do 
    it "creates a new video"
  end

end
