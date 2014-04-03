require 'spec_helper'

describe UsersController do
  describe "users#new" do
    it "assigns a new User obj to @user" do
      get :new
      expect(assigns(:user)).to be_a_new User
    end
  end
  
  describe "users#create" do
    context "user data pass validation" do
      it "save user to db" do
        expect{
          post :create,user: Fabricate.attributes_for(:user)
        }.to change(User, :count).by(1)
      end
      it "redirects to videos_path" do
        post :create,user: { name: "crokobit", password: "pw" }
        expect(response).to redirect_to videos_path
      end
    end

    context "user data does not pass validation" do
      it "renders :new" do
        post :create ,user: Fabricate.attributes_for(:invalid_user)
        expect(response).to render_template :new 
      end
    end
  end
end
