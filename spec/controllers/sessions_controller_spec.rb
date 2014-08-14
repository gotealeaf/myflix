require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unathenticated users" do
      get :new
      expect(response).to render_template :new
    end
    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      before do 
        abby = Fabricate(:user)
        post :create, email: abby.email, password: abby.password
      end

      it "puts the signed in user in the session" do
        abby = Fabricate(:user)
        post :create, email: abby.email, password: abby.password
        expect(session[:user_id]).to eq(abby.id)
      end

      it "redirects the user to the home page" do
        expect(response).to redirect_to home_path
      end

      it "sets the notice" do 
        expect([:success]).not_to be_blank
      end
    end

    context "with invalid credentials"
    before do
      abby = Fabricate(:user)
      post :create, email: abby.email, password: abby.password + 'aldkjalkda'
    end
      it "does not put the user in the session" do
        expect(session[:user_id]).to be_nil
      end
      it "redicts user to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end
      it "sets the error message" do 
       expect(flash[:danger]).not_to be_blank
     end
  end

describe "GET destroy" do
  before do
    session[:user_id] = Fabricate(:user).id
    get :destroy
  end

  it "clears the user session" do
    expect(session[:user_id]).to be_nil
  end
  it "redirects user to root_path" do
    expect(response).to redirect_to root_path
  end
  it "sets the sign out notice" do
    expect([:success]).not_to be_blank
  end
end

end