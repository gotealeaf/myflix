require "rails_helper"

describe PasswordResetsController do
  describe "GET show" do
    it "renders the show template if token is valid" do
      alice = Fabricate(:user)
      alice.update_column(:token, '123')

      get :show, id: '123'

      expect(response).to render_template :show
    end

    it "sets @token" do
      alice = Fabricate(:user)
      alice.update_column(:token, '123')

      get :show, id: '123'

      expect(assigns(:token)).to eq('123')
    end

    it "redirects to the expired token page if token is invalid" do
      get :show, id: '123'

      expect(response).to redirect_to expired_token_path
    end
  end #GET show

  describe "POST create" do
    context "with valid token" do
      it "redirects to the sign in page" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '123')

        post :create, token: '123', password: 'new_password'

        expect(response).to redirect_to sign_in_path
      end

      it "updates the user's password" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '123')

        post :create, token: '123', password: 'new_password'

        expect(alice.reload.authenticate('new_password')).to be_truthy
      end

      it "sets the flash message" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '123')

        post :create, token: '123', password: 'new_password'

        expect(flash[:success]).to be_present
      end

      it "regenerates the user's token" do
        alice = Fabricate(:user, password: 'old_password')
        alice.update_column(:token, '123')

        post :create, token: '123', password: 'new_password'

        expect(alice.reload.token).not_to eq('123')
      end
    end

    context "with invalid token" do
      it "redirects to the expired token path" do
        post :create, token: '123', password: 'some_password'

        expect(response).to redirect_to expired_token_path
      end
    end
  end #POST create
end