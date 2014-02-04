require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST create" do
    context "with blank input" do
      it "redirects to the forgot passowrd page" do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end
      it "shows an error message" do
        post :create, email: ''
        expect(flash[:error]).to eq("Email can not be blank!")
      end
    end

    context "with existing email" do
      it "redirects to the forgot password confirmation page" do
        sam = Fabricate(:user, email: "jenny@example.com")
        post :create, email: "jenny@example.com" 
        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it "sends email to the email address" do
        Fabricate(:user, email: "jenny@example.com")
        post :create, email: "jenny@example.com" 
        expect(ActionMailer::Base.deliveries.last.to).to eq(["jenny@example.com"])
      end
    end

    context "with non-existing email" do
      it "redirects to the forgot_password_path" do
        post :create, email: "jenny@example.com" 
        expect(response).to redirect_to forgot_password_path
      end
      it "shows a error message" do
        post :create, email: "jenny@example.com" 
        expect(flash[:error]).to eq("There is no user with that email in system.")
      end
    end
  end
end
