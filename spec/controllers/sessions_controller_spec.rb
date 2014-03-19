require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to home if user is logged in" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to :home
    end
    it "renders new template if user is not logged in" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    let(:fake_user) { Fabricate(:user) }
    context 'with valid credentials' do
      before { post :create, { email: fake_user.email, password: fake_user.password } }
      
      it "puts user_id into session" do
        expect(session[:user_id]).to eq(fake_user.id)
      end

      it "redirects to home" do
        expect(response).to redirect_to :home
      end
    end

    context 'with invalid credentials' do
      before { post :create, { email: fake_user.email, password: "wrongpassword" } }
      
      it "does not put the user_id in the sesion" do
        expect(session[:user_id]).to be_nil
      end

      it "renders new template" do
        expect(response).to render_template :new
      end

      it "sets the flash message" do
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    it "clears the user_id in the session" do
      expect(session[:user_id]).to be_nil
    end
    it "redirects to the root path" do
      expect(response).to redirect_to :root
    end
    it "sets the flash notice" do
      expect(flash[:notice]).not_to be_blank
    end
  end
  
end
