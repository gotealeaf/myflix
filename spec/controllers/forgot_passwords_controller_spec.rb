require 'spec_helper'

describe ForgotPasswordsController do
  
  describe "GET new" do
    #note no need to do new action test because no instance variables need to be set. Also, just rendering default template
  end #ends GET new
  
  describe "POST create" do
    
    context "empty input" do
      
      it 'should redirect to the forgot password page' do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end
      
      it 'should show the flash message' do
        post :create, email: ''
        expect(flash[:danger]).to eq("You did not enter an email address.")
      end
    end #ends empty input context
    
    context "valid input" do
      let(:jane) { Fabricate(:user) }
      
      it 'should send an email to the user' do
        post :create, email: jane.email
        expect(ActionMailer::Base.deliveries.last.to).to eq([jane.email])
      end
      
      it 'should redirect to the password reset sent page' do
        post :create, email: jane.email
        expect(response).to redirect_to forgot_password_confirmation_path
      end
      
    end #ends valid input with existing email
    
    context "invalid input" do
      
      it 'should show the flash error message' do
        post :create, email: "foo@example.com"
        expect(flash[:danger]).to eq("There is no user associated with that email address.")
      end
      
      it 'should redirect to the forgot password page' do
        post :create, email: "foo@example.com"
        expect(response).to redirect_to forgot_password_path
      end
      
    end #ends invalid input with wrong email
  end #ends POST create
end # ends Controller test