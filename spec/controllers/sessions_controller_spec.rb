require "spec_helper"

describe SessionsController do  
  describe "GET new" do
    it "renders new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirect to video page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to videos_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      let(:paquito) { Fabricate :user }

      before do
        post :create, email: paquito.email, password: paquito.password
      end  

      it "puts the signed in user in the session" do        
        expect(session[:user_id]).to eq(paquito.id) 
      end

      it "redirect to videos path" do
        expect(response).to redirect_to videos_path
      end

      it "sets the notice" do
        expect(flash[:notice]).to eq("You are logged in.")
      end
    end

    context "with invalid credentials" do
      before do
        paquito = Fabricate :user
        post :create, email: "malemail@gmail.com", password: paquito.password
      end      

      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirect to sign_in page" do
        expect(response).to redirect_to sign_in_path
      end 

      it "sets the notice" do
        expect(flash[:error]).to eq("email and/or password are not correct.")
      end
    end
  end 

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "sets session[user_id] to nil" do
      expect(session[:user_id]).to be_nil
    end

    it "redirect to root path when the session is destroyed" do
      response.should redirect_to root_path
    end

    it "sets the notice" do
      expect(flash[:notice]).to eq("You are signed out.")
    end
  end
end