require 'spec_helper'

describe PasswordResetController do

  let(:current_user) { Fabricate(:user) }

  describe "GET show" do
    it "renders show template if valid token" do
      get :show, id: current_user.token
      expect(response).to render_template :show
    end

    it "assigns @token if valid token" do
      get :show, id: current_user.token
      expect(assigns(:token)).to eq(current_user.token)
    end

    it_behaves_like "invalid token expired" do
      let(:action) { get :show, id: "123123" }
    end
  end


  describe "POST create" do
    context "with valid token" do

      before { post :create, token: current_user.token, password: "00000000", password_confirmation: "00000000" }

      it "updates the user's password" do
        expect(current_user.reload.authenticate("00000000")).to eq(current_user)
      end

      it "redirects the sign in page" do
        expect(response).to redirect_to signin_path
      end

      it "set flash message" do
        expect(flash[:success]).not_to be_blank
      end

      it "regenerate token" do
        expect(current_user.token).not_to eq(current_user.reload.token)
      end
    end

    it_behaves_like "invalid token expired" do
      let(:action) { get :show, id: "123123" }
    end
  end
end
