require 'spec_helper'

describe PasswordResetsController do
  
  describe "GET Show" do
    
    it 'should render the reset password page if token is valid' do
      jane = Fabricate(:user)
      jane.update_column(:token, '12345')
      #note: we have to put update column because as the user is fabricated, a new random string is created as part of it, so, it will not match our token. 
      get :show, id: '12345'
      expect(response).to render_template :show
    end
    
    it 'should redirect to the invalid token path if token is invalid' do
      get :show, id: '23456'
      expect(response).to redirect_to invalid_token_path
    end
    
    it 'should set the @token' do
      jane = Fabricate(:user)
      jane.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq('12345')
    end
  end #ends GET Show
  
  describe "POST create" do
    
    context "valid token" do
      let(:jane) { Fabricate(:user, password: 'old_password') }
      
      it 'should reset the password' do
        jane.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(jane.reload.authenticate('new_password')).to be_true
      end
      
      it 'should show a flash message displaying that password reset was successful' do
        jane.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(flash[:success]).to eq("Your password was successfully changed.")
      end
      
      it 'should redirect to the sign in page' do
        jane.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(response).to redirect_to login_path
      end
      
      it 'should regenerate a new token for the user' do #to decrease risk of someone using the old token to change passwords
        jane.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(jane.reload.token).not_to eq('12345')
      end    
    end #ends valid input context
    
    context "invalid token" do #to prevent someone from attacking the system
      let(:jane) { Fabricate(:user, password: 'old_password') }
      
      it 'should display an error message if password field is blank' do
        jane.update_column(:token, '12345')
        post :create, token: '23456', password: 'new_password'
        expect(flash[:danger]).not_to be_blank
      end
      
      it 'should redirect to the reset password page' do
        jane.update_column(:token, '12345')
        post :create, token: '23456', password: 'new_password'
        expect(response).to redirect_to invalid_token_path
      end
      
    end #ends invalid input context
  end #ends POST create
end