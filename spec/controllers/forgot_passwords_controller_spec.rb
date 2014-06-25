require 'spec_helper'

describe ForgotPasswordsController do

  describe "GET new" do

    it "displays the password reset page"

  end #GET new

  describe "POST create" do

    context "with blank input" do
      it "redirects to the forgot passwd page" do
        post :create, email: ""
        expect(response).to redirect_to(forgot_password_path)
      end

      it " shows an error message" do
        post :create, email: ""
        expect(flash[:error]).to eq("Email cannot be blank")
      end
    end

    context "with existing email" do

       after { ActionMailer::Base.deliveries.clear }
      
      it "sends to password confirmation page" do
        Fabricate(:user, email: "joe@example.com")
        post :create, email: "joe@example.com"
        expect(response).to redirect_to forgot_password_confirmation_path
      end 

      it "send an email to the email address " do
        Fabricate(:user, email: "joe@example.com")
        post :create, email: "joe@example.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
      end
    end #context with existing email

    context "with non existant email" do
      it "redirects to forgot password page" do
        post :create, email: "joe@example.com"
        expect(response).to redirect_to forgot_password_path
      
      end

      it "shows an error message" do
        post :create, email: "joe@example.com"
        expect(flash[:error]).to eq("Email not found. Please check your email")
      end
    end



  end #POST create

end
