require 'spec_helper'


describe SessionsController do
  describe 'GET new' do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to videos_path
    end
  end

  describe 'POST create' do
    context "with valid credentials" do
      before do
        user = Fabricate(:user)
        post :create, {email: user.email, password: user.password}
      end

      it "sets the user in the session if user is authenticated" do
=begin this test only works when I repeat the code that I have in the before block.
       if I remove it, assuming that the code in the block will take care of everything, 
       the test breaks. 
=end 
        user = Fabricate(:user)
        post :create, {email: user.email, password: user.password}

        expect(session[:user_id]).to eq(user.id)
      end

      it "sends the user to his dashboard when the user is authenticated" do
        expect(response).to redirect_to videos_path
      end

      it "sets the notice" do
        expect(flash[:notice]).to eq("Logged in!")
      end
    end

    context "with invalid credentials" do
      before do
        user = Fabricate(:user)
        post :create, {email: user.email}
      end

      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects the user to the new tempate when the password and email are invalid" do
        expect(response).to render_template('sessions/new')
      end

      it "sets the error message" 
    end
  end
  describe "GET destroy" do
    before do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :destroy
    end

    it "clears the sessions for the user" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end

    it "sets the notice" do
      expect(flash[:notice]).to eq("Logged out!")
    end
  end
end