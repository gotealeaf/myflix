require 'spec_helper'

describe PasswordResetsController do

  let(:hank)  { Fabricate(:user) }
# #######################################################

  describe 'GET show' do
    it_behaves_like "does_not_require_sign_in" do
       let(:action) {get :show, id:1}
    end

    it "redirects to expired token when the token is INvalid" do
      get :show, id:1
      expect(response).to redirect_to invalid_token_path
    end

  end

  describe 'POST create' do

    context "with valid token" do

      it "updates the password" do
        joe = Fabricate(:user, password: 'old password')
        tok = SecureRandom::urlsafe_base64
        joe.update_attributes(token: tok)
        post :create, password: "new password", token: tok
        expect(joe.reload.authenticate("new password")).to be_true
      end


      it "sets the flash message" do
        tok = SecureRandom::urlsafe_base64
        hank.update_attributes(token: tok)
        post :create, password: "password", token: tok
        expect(flash[:notice]).to be_present
      end    

      it "redirects to sign in when the token is valid" do
        tok = SecureRandom::urlsafe_base64
        hank.update_attributes(token: tok)
        post :create, password: "password", token: tok
        expect(response).to redirect_to sign_in_path
      end

      it "resets the token" do
        tok = SecureRandom::urlsafe_base64
        hank.update_attributes(token: tok)
        post :create, password: "password", token: tok
        expect(User.find(hank.id).token).to_not eq(tok)
      end

    end

    context "with INvalid token " do

      it "redirects to expired token path" do
        tok = SecureRandom::urlsafe_base64
        hank.update_attributes(token: tok)
        post :create, password: "password", token: tok + 'fake'
        expect(response).to redirect_to invalid_token_path
      end
    end
  end

end
