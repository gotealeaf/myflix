require 'spec_helper'

describe ForgotPasswordsController do

  describe "POST create" do
    context "with existing email" do
      it "emails the user with the password reset link" do
        Fabricate(:user, email: "darren@example.com")
        post :create, email: "darren@example.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["darren@example.com"])
      end
      it "redirects to the Confirm Password Reset page" do
        Fabricate(:user, email: "darren@example.com")
        post :create, email: "darren@example.com"
        expect(response).to redirect_to confirm_password_reset_path
      end
    end
    context "with non-existing email" do
      it "redirects to the forgot password page" do
        post :create, email: 'wrong@example.com'
        expect(response).to redirect_to forgot_password_path
      end
      it "creates a flash message saying user does not exist" do
        post :create, email: 'wrong@example.com'
        expect(flash[:error]).to eq("Invalid email address")
      end
    end
  end
  
end