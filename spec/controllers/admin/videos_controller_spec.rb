require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it_behaves_like "require sign in" do
      let(:action) { get :new }
    end
    it "should set the @video instance variable" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record
    end
    it "should redirect non-admin users to the root" do
      set_current_user
      get :new
      expect(response).to redirect_to root_path
    end
    it "should set a flash error message for non-admin users" do
      set_current_user
      get :new
      expect(flash[:error]).to be_present
    end
  end
end