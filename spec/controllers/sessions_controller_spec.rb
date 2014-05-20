require 'spec_helper'

describe SessionsController do
  
  context "user has not authenticated" do
    let(:user) {Fabricate(:user)}
    describe "GET #new" do
      it "renders new session template" do
        get :new
        expect(response).to render_template(:new)
      end
      
    end
    describe "POST #create" do
      context "valid credentials" do
        before {post :create, email: user.email , password: user.password}
        it "should redirect to home page" do
          expect(response).to redirect_to(home_path)
        end
        it "puts the user into the session" do
          expect(session[:user_id]).to eq user.id
        end
        it "sets the notice" do
          expect(flash[:notice]).not_to be_blank
        end
      end
      
      context "invalid credentials" do
        before {post :create, email: user.email , password: user.email + 'xyz'}
        it "should redirect to the signin page" do
          expect(response).to redirect_to(sign_in_path)
        end
        it "should not put the user in the session" do
          expect(session[:user_id]).to be_nil
        end
        it "should set the error message" do
          expect(flash[:error]).not_to be_blank
        end
        
      end
    end
        
  end
  
  context "user is authenticated" do
    before do
      user = Fabricate(:user)
      session[:user_id] = user.id
    end
    describe "GET #new" do
      it "should redirect to home page" do
        get :new
        expect(response).to redirect_to(home_path)
      end
    end
    
    describe "GET #destroy" do
      it "should redirect to the root path" do
        get :destroy
        expect(response).to redirect_to(root_path)
      end
      it "should clear the user from the session" do
        get :destroy
        expect(session[:user_id]).to be_nil
      end
    end
  end
  
end