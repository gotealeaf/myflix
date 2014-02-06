require 'spec_helper'

describe ForgotPasswordsController, sidekiq: :inline  do

  describe "POST create"  do
   # ActionMailer::Base.deliveries.clear

    context "with blank email" do
      it" redirects to the forgot passsword page" do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end
      it "shows the error message" do
        post :create, email: ''
        expect(flash[:error]).to eq("You must enter your email address.")
      end
    end

    context "with an email not in the system" do
      it "redirects to the forgot passsword page" do
          post :create, email: 'me@them.com'
          expect(response).to redirect_to forgot_password_path
      end
      it "shows the error message" do
        post :create, email: 'me@them.com'
        expect(flash[:error]).to eq("The email address is not in the system.")
      end
    end

    context "with an email in the system" do 
      let!(:alice) {Fabricate(:user)}
      it "should redirect to the confirm password reset page" do
        # alice = Fabricate(:user)
        post :create, email: alice.email
        expect(response).to redirect_to forgot_password_confirmation_path
      end
      it "should send an email to the user" do
        post :create, email: alice.email
        expect(ActionMailer::Base.deliveries.last.to).to eq([alice.email])
      end
    end
  end
end