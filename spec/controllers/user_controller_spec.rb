require 'spec_helper'

describe UsersController do
  context "with authenticated user" do
    before { session[:user_id] = Fabricate(:user).id}
    describe "GET #new" do
      it "redirects to home path" do
        get :new
        expect(response).to redirect_to home_path
      end
    end
    describe "POST #create" do
      it "redirects to home path" do
        post :create
        expect(response).to redirect_to home_path
      end
    end
  end

  context "with unathenticated user" do
    describe "GET #new" do
      it "assigns a new User to @user" do 
        get :new
        expect(assigns(:user)).to be_new_record
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
    describe "POST #create" do
      context "with valid attributes" do
        before { post :create, user: Fabricate.attributes_for(:user) }
        it "saves the new user" do
          expect(User.count).to eq(1)
        end
        it "redirects to the home path" do
          expect(response).to redirect_to home_path
        end
        it "logs the user in" do
          expect(session[:user_id]).to be_true
        end
      end
      context "with invald attributes" do
        before { post :create, user: Fabricate.attributes_for(:user, name: nil) }
        it "sets the @user variable" do
          expect(assigns(:user)).to be_new_record
          expect(assigns(:user)).to be_instance_of(User)
        end
        it "does not save the new user" do 
          expect(User.count).to eq(0)
        end
        it "re-renders the :new template" do
          expect(response).to render_template(:new)
        end
      end
    end
  end
end