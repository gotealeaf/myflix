require 'spec_helper'

describe ResetPasswordsController do
  describe "GET show" do
    it "renders page for submitting a new password" do
      get :submit_password
      expect(response).to render_template('reset_passwords/submit_password')
    end
  end
end