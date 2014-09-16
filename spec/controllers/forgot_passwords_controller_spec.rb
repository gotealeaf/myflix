require 'spec_helper'

describe ForgotPasswordsController do 
  describe "POST create" do
    context "with blank input" do
      it "redirects to the forgot password page" do
        post :create, email: ''
        response.should redirect_to forgot_password_path
      end
      it "shows an error message" do
        post :create, email: ''
        flash[:error].should == "Email cannot be blank."
      end
    end
    context "with existing email" do 
      it "redirect to the forgot password confirmaiton page" do
        Fabricate(:user, email: "joe@example.com")
        post :create, email: "joe@example.com"
        response.should redirect_to forgot_password_confirmation_path 
      end

      it "sends out an email to the email address" do
        Fabricate(:user, email: "joe@example.com")
        post :create, email: "joe@example.com"
        ActionMailer::Base.deliveries.last.to.should == ["joe@example.com"]
      end

    end
    context "with non-existing email" do 
      it "redirects to the forgot password page" do
        post :create, email: 'foo@example.com'
        response.should redirect_to forgot_password_path
      end

      it "shows an error message" do 
        post :create, email: 'foo@example.com'
        flash[:error].should == "There is no user with that email"
      end
    end
  end  
end