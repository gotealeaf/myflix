require 'spec_helper'

describe ForgotPasswordsController do
  describe "GET email_page" do
    it "renders page for submitting an email" do
      get :email_page
      expect(response).to render_template(:email_page)
    end
  end

  describe "POST create" do

    let(:bob) { Fabricate(:user, email: "bob@example.com", token: '12345') }

    it "redirects to confirm_password_reset page" do
      post :create, email: bob.email
      expect(response).to redirect_to(confirm_password_reset_path)
    end
    it "renders unknown user notice when incorrect email is submitted" do
      post :create, email: "cat@example.com"
      expect(flash[:notice]).to eq("Unknown user email")
    end
    it "sends an email to the user" do
      post :create, email: bob.email
      message = ActionMailer::Base.deliveries
      expect(message.last.to).to eq([User.last.email])
    end
  end
end