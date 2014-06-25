require 'spec_helper'

describe PasswordResetsController do

  describe "GET show" do

    it "renders show template for valid token" do
      alice = Fabricate(:user)
      alice.update_column(:token, '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end
    it  "sets @token" do
      alice = Fabricate(:user)
      alice.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq '12345'
    end
    it "redirects to expired token template for invalid token" do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end
  end #GET show

  describe "POST create" do
    context "with valid token" do
       it "redirects to sign in page" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(response).to redirect_to sign_in_path
       end
      it "updates the password for the user with valid token" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'

        expect(alice.reload.authenticate('new_password')).not_to be false
        
      end
     
      it "flashes success message" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'

        expect(flash[:success]).to be_present
      end
      it "regenerates the users token" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'

        expect(alice.reload.token).not_to eq('12345')

      end
    end #context valid token

    context "with invalid token" do
      it "redirects to expired token path" do

        post :create, token: '12345', password: 'new_password'

        expect(response).to redirect_to expired_token_path

      end

    end
  end

end
