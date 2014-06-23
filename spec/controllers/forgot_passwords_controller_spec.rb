require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST create" do
    context "with blank email"do
      it "redirects to the forgot password page" do
        post :create, email: ""
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        post :create, email: ""
        expect(flash[:error]).to eq("Email field cannot be blank.")
      end
    end

    context "with existing email" do
      it "redirects to the forgot password confirmation page" do
        ana = Fabricate :user, email: "paq@paq.com"
        post :create, email: "paq@paq.com"

        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it "sends an email to the email addres" do
        ana = Fabricate :user, email: "paq@paq.com"
        post :create, email: "paq@paq.com"

        expect(ActionMailer::Base.deliveries.last.to).to eq(["paq@paq.com"])
      end

      it "sets reset_password_email_sent_at with the current time" do
        ana = Fabricate :user, email: "paq@paq.com"
        post :create, email: "paq@paq.com"

        expect(ana.reload.reset_password_email_sent_at).to eq(ActionMailer::Base.deliveries.last.date)        
      end
    end

    context "with non existing email" do
      it "redirects to the forgot password page" do
        post :create, email: "tok@tok.com"
        expect(response).to redirect_to forgot_password_path
      end
      
      it "shows an errror message" do
        post :create, email: "tok@tok.com"
        expect(flash[:error]).to eq("There is no user with that email in the system")
      end
    end
  end
end