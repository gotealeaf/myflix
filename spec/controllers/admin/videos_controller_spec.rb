require 'spec_helper'

describe Admin::VideosController do
  
  describe "GET new" do
    it "sets the @video instance variable" do
      set_admin
      get :new
      expect(assigns(:video)).to be_instance_of(Video)
      expect(assigns(:video)).to be_new_record
    end
    
    it "redirects to home path if user is not authorised to access the page" do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end
    
    it "displays a flash message" do
      set_current_user
      get :new
      expect(flash[:danger]).not_to be_blank
    end
    
    it_behaves_like "require sign in" do
      let(:action) {get :new}
    end
  end # ends the GET new test  
end