require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST create" do
    context "blank input" do
      it "redirects to forgot password page" do
        post :create, email: ""
        expect(response).to redirect_to forgot_password_path
      end

      it "sets a flash error message" do
        post :create, email: ""
        expect(flash[:danger]).to eq("Email cannot be blank.")
      end
    end

    context "email in system" do
      around { ActionMailer::Base.deliveries.clear }

      it "shows confirm password reset page" do
        alice = Fabricate(:user)
        post :create, email: alice.email
        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it "sends out an email" do
        alice = Fabricate(:user)
        post :create, email: alice.email
        expect(ActionMailer::Base.deliveries).not_to be_empty
      end

      it "sends the email to the input address" do
        alice = Fabricate(:user)
        post :create, email: alice.email
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([alice.email])
      end

      it "sends the email with token link" do
        alice = Fabricate(:user)
        post :create, email: alice.email
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("<a href=\"http://localhost:3000/password_resets/#{alice.token}\">Reset Password</a>")
      end
    end

    context "email not in system" do
      it "redirects to forgot password page" do
        post :create, email: "someguy@test.com"
        expect(response).to redirect_to forgot_password_path
      end

      it "sets a flash error message" do
        post :create, email: "someguy@test.com"
        expect(flash[:danger]).to eq("Sorry, that email does not exist in our records.")
      end

    end
  end
end