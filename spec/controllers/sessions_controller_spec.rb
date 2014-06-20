require "rails_helper"

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
  end # GET new

  describe "POST create" do
    context "with valid sign in credentials" do
      before do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
      end
      
      it "saves the signed in user to the session" do
        expect(session[:user_id]).to eq(alice.id)
      end

      it "redirects the user to the home path" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid sign in credentials" do
      before do
        bill = Fabricate(:user)
        post :create, email: bill.email, password: bill.password + "ahafafav"
      end

      it "doesn't save the user to the session" do
        expect(session[:user_id]).to be_nil
      end
      
      it "redirects to the sign in path" do
        expect(response).to redirect_to sign_in_path
      end
      
      it "sets the notice" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end # POST create

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "removes the user from the session" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end

    it "sets the notice" do
      expect(flash[:success]).not_to be_blank
    end
  end # GET destroy
end