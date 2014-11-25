require 'spec_helper'

describe ForgotPasswordsController do 
  describe "POST create" do 

    after {ActionMailer::Base.deliveries.clear}
    
    context "with blank input" do 
      it "redirects to the forgot password page" do 
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end
      
      it "shows an error message" do 
        post :create, email: ''
        expect(flash[:error]). to eq("Email cannot be blank")
      end
    end
    
    context "with existing email" do 
      it "redircts to the forgot password confirmation page" do 
        Fabricate(:user, email: "joe@example.com")
        post :create, email: "joe@example.com"
        expect(response).to redirect_to forgot_password_confirmation_path
      end
      
      it "sends out email to the email address" do 
        Fabricate(:user, email: "joe@example.com")
        post :create, email: "joe@example.com"
        message = ActionMailer::Base.deliveries.last
        message.to.should eq ["joe@example.com"]
      end
    end
    
    context "with non-existing email"
  end
end