require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders show template if the token is valid" do
      ana = Fabricate :user
      ana.update_column(:token, '12345')
      get :show, id: '12345'

      expect(response).to render_template :show
    end

    it "sets @user" do
      ana = Fabricate :user
      ana.update_column(:token, '12345')
      get :show, id: '12345'

      expect(assigns :user).to eq(ana)
    end

    it "redirects to expired token page if the token is not valid" do
      get :show, id: "diej"
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do
    context "with valid token" do
      it "redirects to sign in page" do
        ana = Fabricate :user
        ana.update_column(:token, '12345')
        ana.password = 'old_password'

        post :create, token: '12345', password: 'new_password'

        expect(response).to redirect_to sign_in_path
      end

      it "updates the user's password" do
        ana = Fabricate :user, password: 'old_password', password_confirmation: 'old_password'
        ana.update_column(:token, '12345')
        
        post :create, token: '12345', password: 'new_password'

        expect(ana.reload.authenticate('new_password')).to be_true  
      end

      it "sets the flash success page" do
        ana = Fabricate :user, password: 'old_password', password_confirmation: 'old_password'
        ana.update_column(:token, '12345')
        
        post :create, token: '12345', password: 'new_password'

        expect(flash[:notice]).to eq("You have successfully changes your password")

      end

      it "regenerates the user's token" do
        ana = Fabricate :user, password: 'old_password', password_confirmation: 'old_password'
        ana.update_column(:token, '12345')
        
        post :create, token: '12345', password: 'new_password'

        expect(ana.reload.token).to_not eq("12345")        
      end
    end

    context "with invalid token" do
      it "redirects to espired token path" do
        post :create, token: '3214', password: 'new_password'
        expect(response).to redirect_to expired_token_path         
      end
    end
  end
end