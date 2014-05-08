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

  describe "POST create" do
    context "admin signed in" do
      context "input is valid" do
        it "saves the video" do
          set_current_user(Fabricate(:admin))
          post :create, video: Fabricate.attributes_for(:video)
          expect(assigns(:video)).to be_instance_of(Video)
          expect(assigns(:video).save).to be_true
        end

        it "sets a flash success message" do
          set_current_user(Fabricate(:admin))
          post :create, video: Fabricate.attributes_for(:video)
          expect(flash[:success]).to eq("The video #{Video.first.title} has been saved!")
        end

        it "renders the new video template" do
          set_current_user(Fabricate(:admin))
          post :create, video: Fabricate.attributes_for(:video)
          expect(response).to redirect_to new_admin_video_path
        end
      end

      context "input is not valid" do
        it "does not save the video" do
          set_current_user(Fabricate(:admin))
          post :create, video: Fabricate.attributes_for(:video, title: "")
          expect(assigns(:video).save).to be_false
        end

        it "sets a flash danger message" do
          set_current_user(Fabricate(:admin))
          post :create, video: Fabricate.attributes_for(:video, title: "")
          expect(flash[:danger]).to eq("The video could not be saved, due to the following errors:")
        end      

        it "renders the new video template" do
          set_current_user(Fabricate(:admin))
          post :create, video: Fabricate.attributes_for(:video, title: "")
          expect(response).to render_template :new
        end
      end
    end

    context "non-admin user signed in" do
      it "sets flash danger message" do
        set_current_user(Fabricate(:user))
        post :create
        expect(flash[:danger]).to eq("You do not have permission to do that.") 
      end

      it "redirects to home" do
        set_current_user(Fabricate(:user))
        post :create
        expect(response).to redirect_to home_path        
      end     
    end
      
    context "no user signed in" do
      before { post :create }

      it "sets flash danger message" do 
        expect(flash[:danger]).to eq("You must be logged in to do that.") 
      end

      it_behaves_like "requires login"
    end
  end
end