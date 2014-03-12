require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it_behaves_like "require sign in" do
      let(:action) { get :new }
    end
    it_behaves_like "require admin" do
      let(:action) { get :new }
    end
    it "should set the @video instance variable" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record
    end
    it "should set a flash error message for non-admin users" do
      set_current_user
      get :new
      expect(flash[:error]).to be_present
    end
  end
  describe "POST create" do
    it_behaves_like "require sign in" do
      let(:action) { post :create }
    end
    it_behaves_like "require admin" do
      let(:action) { post :create }
    end
    context "valid input" do
      it "should redirect to the Add New Video page" do
        set_current_admin
        post :create, video: {title: "Gandhi", description: "great video", category: Fabricate(:category)}
        expect(response).to redirect_to new_admin_video_path
      end
      it "should create a record in the video model" do
        set_current_admin
        post :create, video: {title: "Gandhi", description: "great video", category: Fabricate(:category)}
        expect(Video.count).to eq(1)
      end
      it "should send a success message" do
        set_current_admin
        post :create, video: {title: "Gandhi", description: "great video", category: Fabricate(:category)}
        expect(flash[:success]).to be_present
      end
    end
    context "invalid input" do
      it "should render the Add New Video page" do
        set_current_admin
        post :create, video: {description: "great video", category: Fabricate(:category)}
        expect(response).to render_template :new
      end
      it "should not create a video" do
        set_current_admin
        post :create, video: {description: "great video", category: Fabricate(:category)}
        expect(Video.count).to eq(0)
      end
      it "should send a failure message" do
        set_current_admin
        post :create, video: {description: "great video", category: Fabricate(:category)}
        expect(flash[:error]).to be_present
      end
      it "should set the @video variable" do
        set_current_admin
        post :create, video: {description: "great video", category: Fabricate(:category)}
        expect(assigns(:video)).to be_present
      end
    end

  end
end