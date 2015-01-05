require 'rails_helper'

describe UsersController do 

  describe 'GET New' do
    it 'should create a new instance of User' do
      get :new
      assigns(:user).should be_an_instance_of User
    end
    it 'should render the new template' do
      get :new
      response.should render_template :new
    end
  end
  
  describe 'POST Create' do    
    it 'should redirect to sessions/new if registration successful' do
      post :create, user:{email: 'example@123.com', password: '12345'}
      response.should redirect_to login_path
    end

    it 'should fail if email is not valid' do 
      post :create, user:{email: '', password: '12345'}
      response.should render_template :new
    end
    it 'should fail if password is not valid' do
      post :create, user:{email: 'example@example.com', password: '123'}
      response.should render_template :new 
    end
    it 'should faile if email is already been taken' do
      user = User.create(email: 'example@example.com', password: '12345')
      post :create, user:{email: 'example@example.com', password: '12345'}
      response.should render_template :new
    end
  end  
end