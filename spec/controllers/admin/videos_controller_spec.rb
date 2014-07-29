require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
    it "sets the @video to a new video" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record
    end
    it "redirects the regular user to the home path" do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end
    it "sets the flash error message for regular user" do
      set_current_user
      get :new
      expect(flash[:danger]).to be_present
    end
  end
end