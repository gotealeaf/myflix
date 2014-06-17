require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user instance variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end # ends the GET new test
  
  describe "GET new_with_token" do
    
    it 'sets the @user with the email address of the recipient' do
      invitation = Fabricate(:invitation)
      get :new_with_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end
    
    it 'renders the new view template' do
      invitation = Fabricate(:invitation)
      get :new_with_token, token: invitation.token
      expect(response).to render_template :new
    end
    
    it 'sets the @invitation_token' do #to track the person who invited the new user
      invitation = Fabricate(:invitation)
      get :new_with_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end
    
    it 'redirects to expired token page for invalid tokens' do
      get :new_with_token, token: '23456'
      expect(response).to redirect_to invalid_token_path
    end
  end
  
  describe "POST create" do
    
    context "successful user signup" do
      
      it "redirects to videos path" do
        result = double(:sign_up_result, successful?: true)
        UserSignUp.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user) 
        response.should redirect_to videos_path
      end
    end # ends context successful user signup
    
    context "failed user signup" do
      
      it "renders the new template" do
        result = double(:sign_up_result, successful?: false, error_message: "This is an error message")
        UserSignUp.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12345'
        expect(response).to render_template :new
      end
      
      it "sets the @user instance variable" do
        result = double(:sign_up_result, successful?: false, error_message: "This is an error message")
        UserSignUp.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12345'
        expect(assigns(:user)).to be_instance_of User
      end
      
      it "sets the flash error message" do
        result = double(:sign_up_result, successful?: false, error_message: "This is an error message")
        UserSignUp.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12345'
        flash[:danger] = "This is an error message."
      end
    end
  end #ends POST create 
  
  describe "GET Show" do
    let(:jane) { Fabricate(:user) }
    it 'should set the @user' do
      set_current_user(jane)
      get :show, id: jane.id
      expect(assigns(:user)).to eq(jane)
    end
    
    it_behaves_like "require sign in" do
      let(:action) { get :show, id: jane.id }
    end
  end # ends GET Show
  
  describe "GET Edit" do
    let(:jane) { Fabricate(:user) }
    
    it_behaves_like "require sign in" do
      let(:action) { get :edit, id: jane.id }
    end
  end
  
  describe "POST Update" do
    let(:jane) { Fabricate(:user) }
    
  end
end # ends users controller test