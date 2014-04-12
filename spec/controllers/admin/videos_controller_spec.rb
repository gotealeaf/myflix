require 'spec_helper'

describe Admin::VideosController do

  describe "GET new" do
    let(:addy) { Fabricate(:user, admin: true) }
    before do
      sign_in_user(addy)
      get :new
    end
    context "with a signed in admin user" do
      it "renders the new video page" do
        expect(response).to render_template 'new'
      end
      it "loads a new instance of Video into @video" do
        expect(assigns(:video)).to be_a_new Video
      end
    end
  end

  describe "authorzation required for all areas of admin" do
    context "with a guest (user not signed in)" do
      it_behaves_like "require_signed_in" do
        let(:verb_action) { get :new }
      end
    end

    context "with a standard user who is not an admin" do
      it_behaves_like "require_admin"  do
        let(:verb_action) { get :new }
      end
    end
  end
end
