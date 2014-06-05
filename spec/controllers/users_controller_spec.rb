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
    context "with valid input" do
      before do
        StripeWrapper::Charge.stub(:create)#.and_return(charge)
      end
     
      it "creates a new user" do
        #charge = double('charge')
        #charge.stub(:successful?).and_return(true)
        post :create, user: Fabricate.attributes_for(:user) 
        expect(User.count).to eq(1) 
      end
      
      it "redirects to videos path" do
        post :create, user: Fabricate.attributes_for(:user) 
        response.should redirect_to videos_path
      end
      
      it "makes the user follow the inviter" do #for users invited with token
        jane = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: jane, recipient_email: "joe@example.com")
        post :create, user: { email: "joe@example.com", full_name: "Joe Bloggs", password: "password" }, invitation_token: invitation.token
        joe = User.where(email: "joe@example.com").first
        expect(joe.follows?(jane)).to be_true
      end
      
      it "makes the inviter follow the user" do #for users invited with token
        jane = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: jane, recipient_email: "joe@example.com")
        post :create, user: { email: "joe@example.com", full_name: "Joe Bloggs", password: "password" }, invitation_token: invitation.token
        joe = User.where(email: "joe@example.com").first
        expect(jane.follows?(joe)).to be_true
      end
      
      it "expires the token upon acceptance" do #for users invited with token
        jane = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: jane, recipient_email: "joe@example.com")
        post :create, user: { email: "joe@example.com", full_name: "Joe Bloggs", password: "password" }, invitation_token: invitation.token
        joe = User.where(email: "joe@example.com").first
        expect(Invitation.first.token).to be_nil
      end
    end # ends context with valid input
    
    context "send welcome email" do
      before do
        StripeWrapper::Charge.stub(:create)
      end
      
      after do 
        ActionMailer::Base.deliveries.clear 
      end #this will clear the queue after each run. We have to specify this because ActionMailer is not part of database transactions, so it will not automatically roll back
      
      it 'should send email to the right recipient if input was valid' do
        post :create, user: { email: "user@example.com", password: "password", full_name: "Cool User"}
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(["user@example.com"])
      end
      
      it 'should send email with the right content if input was valid' do
        post :create, user: { email: "user@example.com", password: "password", full_name: "Cool User"}
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include('Cool User')
      end
      
      it 'should not send out email if input was invalid' do
        post :create, user: { email: "user@example.com" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end #ends send welcome email context
    
    context "with invalid input" do
      it "does not create a user" do
        post :create, user: { email: "user@example.com", password: "password" }
        expect(User.count).to eq(0)
      end
      
      it "renders the new template if user is unable to be created" do
        post :create, user: { email: "user@example.com", password: "password" }
        response.should render_template :new
      end
      
      it "sets the @user instance variable to be used in the new template" do
        post :create, user: { email: "user@example.com", password: "password" }
        assigns(:user).should be_instance_of(User)
      end  
    end # ends context with invalid input
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
end # ends users controller test