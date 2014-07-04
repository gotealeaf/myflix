require 'rails_helper.rb'

describe SessionsController do

  describe "GET new" do
    it "renders new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to homepage for authenticated users" do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      before do
        joe = Fabricate(:user)
        post :create, email: joe.email, password: joe.password
      end

      it "adds authenticated user to session" do
        joe = Fabricate(:user)
        post :create, email: joe.email, password: joe.password
        expect(session[:user_id]).to eq(joe.id)
      end

      it "redirects to home_path" do
        expect(response).to redirect_to home_path
      end

      it "sets the notice" do
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "with invalid credentials" do
      before do
        joe = Fabricate(:user)
        post :create, password: joe.password + 'abcd'
      end

      it "does not add user to session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects to sign_in_path" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets error message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    before do
      set_current_user
      get :destroy
    end

    it "sets session to nil" do
      expect(session[:user_id]).to be_nil
    end

    it "sets notice message" do
      expect(flash[:notice]).not_to be_blank
    end

    it "redirects to root_path" do
      expect(response).to redirect_to root_path
    end
  end
end
