require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
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
      let(:lalaine) {Fabricate(:user)}
      before do
        post :create, email: lalaine.email, password: lalaine.password
      end
      it "puts the signed in user in the session" do
        expect(session[:user_id]).to eq(lalaine.id)
      end
      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end
      it "sets the success notice" do
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid credentials" do
      before do
        lalaine = Fabricate(:user)
        post :create, email: lalaine.email, password: lalaine.password + "sljdfdlkjf"
      end

      it "does not put signed in user in session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets the danger notice" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "clears the session for the user" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end

    it "sets the warning notice" do
      expect(flash[:warning]).not_to be_blank
    end
  end
end