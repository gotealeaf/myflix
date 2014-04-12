require 'spec_helper'

describe Admin::VideosController do

  describe "GET new" do
    before do
      sign_in_admin
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

  describe "POST create" do
    let(:drama) { Fabricate(:category, name: "Drama") }

    context "with valid form information" do
      before do
        sign_in_admin
        post :create, { video: { title: "video",
                               description: "a video",
                               categories: ["","#{drama.id}"],
                               small_cover: "/public/tmp/monk.jpg",
                               large_cover: "/public/tmp/monk_large.jpg" }}
      end
      it "loads info into the @video instance variable" do
        expect(assigns(:video)).to be_valid
      end
      it "makes a new video" do
        expect(Video.all.count).to eq(1)
      end
      it "flashes a success notice" do
        expect(flash[:notice]).to be_present
      end
      it "loads the chosen files into the video through a CW uploader"
      it "redirects to the video show page" do
        expect(response).to redirect_to new_admin_video_path
      end
    end
    context "with invalid information" do
      before do
        sign_in_admin
        post :create, { video: { title: nil,
                                 description: "a video",
                                 categories: ["","#{drama.id}"],
                                 small_cover: "/public/tmp/monk.jpg",
                                 large_cover: "/public/tmp/monk_large.jpg" }}
      end
      it "renders the video form" do
        expect(response).to render_template 'new'
      end
      it "does not save the video" do
        expect(Video.all.count).to eq(0)
      end
      it "saves the instance variable info" do
          expect(assigns(:video)).to be_present
      end
      it "flashes a notice of errors" do
        expect(flash[:error]).to be_present
      end
      it "saves any uploaded cover photos in the cache"
    end
  end

  describe "authorzation required for all areas of admin" do
    context "with a guest (user not signed in)" do
      it_behaves_like "require_signed_in" do
        let(:verb_action) { get :new }
      end
      it "sets the flash message for a user who is not allowed" do
        logout_user
        get :new
        expect(flash[:error]).to be_present
      end
     end

    context "with a standard user who is not an admin" do
      it_behaves_like "require_admin"  do
        let(:verb_action) { get :new }
      end
      it "sets the flash message for a user who is not allowed" do
        sign_in_user
        get :new
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "video_params" do
    it "should allow through the noted parameters to make a new video valid"
  end
end
