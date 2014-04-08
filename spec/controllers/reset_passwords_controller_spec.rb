require 'spec_helper'

describe ResetPasswordsController do
  describe "GET show" do
    it "renders page for submitting a new password" do
      bob = Fabricate(:user)
      bob.update_columns(token: bob.generate_token)
      get :show, id: bob.token
      expect(response).to render_template('reset_passwords/show')
    end

    it "renders invalid token page when token has expired" do
      bob = Fabricate(:user)
      get :show, id: '12345'
      expect(response).to redirect_to(expired_token_path)
    end

    describe "POST create" do

    end
  end
end