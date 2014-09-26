require 'spec_helper'

describe Admin::VideosController do 
  describe "GET new" do 
    it_behaves_like "require_sign_in"  do 
      let(:action) { get :new }
    end

    it_behaves_like "requires admin" do
      let(:action) { post :create }
    end
    it "sets @video to a new video" do
      set_current_user_as_admin
      get :new
      assigns(:video).should be_instance_of Video
      assigns(:video).should be_new_record 
    end

    it "sets the flash error message if not admin" do
      set_current_user
      get :new
      flash[:error].should be_present
    end

  end

  describe "POST create" do 
    it_behaves_like "require_sign_in"  do 
      let(:action) { post :create }
    end

    it_behaves_like "requires admin" do
      let(:action) { post :create }
    end

    context "with valid input" do
      it "redirects to the add new video page" do 
        set_current_user_as_admin
        category = Fabricate(:category)
        post :create, video: { title: "Monk", category_id: category.id, description: "good show!" }
        response.should redirect_to new_admin_video_path
      end
      it "creates a video" do 
        set_current_user_as_admin
        category = Fabricate(:category)
        post :create, video: { title: "Monk", category_id: category.id, description: "good show!" }
        category.videos.count.should == 1
      end
      it "sets the flash success message" do 
        set_current_user_as_admin
        category = Fabricate(:category)
        post :create, video: { title: "Monk", category_id: category.id, description: "good show!" }
        flash[:success].should be_present
      end
    end
    context "with invalid input" do
      it "does not create a video" do 
        set_current_user_as_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "good show!" }
        Video.count.should == 0
      end
      it "renders the :new template" do 
        set_current_user_as_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "good show!" }
        response.should render_template :new 
      end
      it "sets the @video variable" do 
        set_current_user_as_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "good show!" }
        assigns(:video).should be_instance_of Video 
      end
      it "sets the flash error message" do 
        set_current_user_as_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "good show!" }
        flash[:error].should be_present
      end
    end
  end
end
