require "spec_helper"

describe SessionsController do
  describe "GET new" do
    it "redirects_to home page if user is authenticated" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    before { @jon = Fabricate(:user, email: "jon@gmail.com") }
    context "with valid input" do
      before { post :create, email: "jon@gmail.com", password: "password" }
      
      it "puts the user into the session" do
        expect(session[:user_id]).to eq(@jon.id)
      end

      it "sets the notice" do
        expect(flash[:notice]).to_not be_blank
      end 
      
      it "redirects to home page" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid input" do
      before { post :create, email: "bob@gmail.com", password: "password" }
      
      it "does not put the user into the session" do
        expect(session[:user_id]).to be_nil
      end

      it "sets the error message" do
        expect(flash[:error]).to_not be_blank
      end
      
      it "renders #new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "logs the user out" do
      expect(session[:user_id]).to eq(nil)
    end

    it "sets the notice" do
      expect(flash[:notice]).to_not be_blank
    end

    it "redirects to front page" do
      expect(response).to redirect_to root_path
    end
  end
end





