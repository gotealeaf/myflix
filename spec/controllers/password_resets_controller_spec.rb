require 'rails_helper.rb'

describe PasswordResetsController do
  describe "GET show" do
    it "renders how template if token is valid" do
      joe = Fabricate(:user)
      joe.update_column(:token, '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end

    it "sets @token" do
      joe = Fabricate(:user)
      joe.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq('12345')
    end

    it "redirects to expired token page if token is not valid" do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do
    context "with valid token" do
      it "redirects to the sign in page" do
        joe = Fabricate(:user, password: 'password')
        joe.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(response).to redirect_to sign_in_path
      end

      it "updates the user's password" do
        joe = Fabricate(:user, password: 'password')
        joe.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        # note rspec 3.0 changed be_true to be_truthy
        expect(joe.reload.authenticate('new_password')).to be_truthy
      end

      it "sets the flash success message" do
        joe = Fabricate(:user, password: 'password')
        joe.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(flash[:success]).to be_present
      end

      it "regenerates the user token" do
        joe = Fabricate(:user, password: 'password')
        joe.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(joe.reload.token).not_to eq('12345')
      end
    end

    context "with invalid token" do
      it "redirects to the expired token page" do
        post :create, token: '12345', password: 'password'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end
