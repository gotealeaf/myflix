require 'spec_helper'
  
describe Admin::VideosController do
  describe "GET new" do
    it "redirects to login page if no user" do
      get :new
      expect(response).to redirect_to login_path
    end

    it "redirects to home if user not admin" do 
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end

    it "sets flash danger message if user not admin" do
      set_current_user
      get :new
      expect(flash[:danger]).to eq("You do not have permission to do that.")
    end

    it "sets @video if user is admin" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of(Video)
      expect(assigns(:video)).to be_new_record
    end
  end
end