require 'spec_helper'

describe UsersController do

  describe 'GET new' do
        it "generates a new record" do
          get :new
          assigns(:user).should be_new_record
        end
  end

  context "the user sign up is valid" do

      describe 'POST create' do
        it "generates a user from valid data" do
          post :create, user: {email: "rick.heller@yahoo.com", password: "password1", full_name: "Rick Heller"}
          assigns(:user).should be_valid
        end

        it "renders redirect to sign_in" do
          post :create, user: {email: "rick.heller@yahoo.com", password: "password1", full_name: "Rick Heller"}
          response.should redirect_to sign_in_path
        end
      end
  end

  context "the user sign up is INVALID" do
      describe 'POST create' do
        it "generates a user from valid data" do
          post :create, user: {email: "", password: "", full_name: ""}
          assigns(:user).should be_new_record
        end

        it "renders redirect to sign_in" do
          post :create, user: {email: "", password: "", full_name: ""}
          response.should render_template :new
        end
      end
  end

end
