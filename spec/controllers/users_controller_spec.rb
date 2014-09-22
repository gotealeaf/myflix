require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "should create @user variable" do
      get :new
      assigns(:user).should be_instance_of(User)
    end
  end

  describe "GET show" do
    it_behaves_like "require_sign_in" do 
      let(:action) { get :show, id: 3 }
    end

    it "sets @user" do 
      set_current_user
      karen = Fabricate(:user)
      get :show, id: karen.id
      assigns(:user).should == karen
    end
   
  end

  describe "POST create" do
    context "with valid input" do 
      before { post :create, user: Fabricate.attributes_for(:user) }
      it "creates user" do
        User.count.should == 1
      end
      it "redirects to sign in path" do 
        response.should redirect_to sign_in_path
      end

      it "makes the user follow the inviter" do
        karen = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: karen, recipient_email: "karen@example.com")
        post :create, user: {email: 'joe@example.com', password: 'password', full_name: 'Joe brown' }, invitation_token: invitation.token
        joe = User.find_by(email: 'joe@example.com')
        karen.follows?(joe).should be_true
      end
      it "makes the inviter follow the user" do
        karen = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: karen, recipient_email: "karen@example.com")
        post :create, user: {email: 'joe@example.com', password: 'password', full_name: 'Joe brown' }, invitation_token: invitation.token
        joe = User.find_by(email: 'joe@example.com')
        joe.follows?(karen).should be_true
      end
      it "expires the invitation upon acceptance" do
        karen = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: karen, recipient_email: "karen@example.com")
        post :create, user: {email: 'joe@example.com', password: 'password', full_name: 'Joe brown' }, invitation_token: invitation.token
        Invitation.first.token.should be_nil
      end
    end
    context "with invalid input" do
      before { post :create, user: { password: "password", full_name: "Bob Dylan" } }
      it "does not create the user" do
        User.count.should == 0
      end
      it "renders the new template" do
        response.should render_template :new
      end
      it "sets @user" do
        assigns(:user).should be_instance_of(User)
      end
    end
    context "sending email" do
      around(:each) { ActionMailer::Base.deliveries.clear }  

      it "sends out the email" do
        karen = { email: "karen@example.com", password: "password", full_name: "Karen Example" }
        post :create, user: karen 
        ActionMailer::Base.deliveries.should_not be_empty    
      end
      it "sends it to the right person" do
        karen = { email: "karen@example.com", password: "password", full_name: "Karen Example" }
        post :create, user: karen 
        message = ActionMailer::Base.deliveries.last
        message.to.should == [karen["email"]]
      end
      it "has the right content" do
        karen = { email: "karen@example.com", password: "password", full_name: "Karen Example" }
        post :create, user: karen 
        message = ActionMailer::Base.deliveries.last
        message.body.should include(karen["full_name"])
      end
      it "does not send email if input is invalid" do
        karen = { email: "karen@example.com"}
        post :create, user: karen 
        ActionMailer::Base.deliveries.should be_empty
      end
    end
  end

  describe "GET new_with_invitation_token" do
    it "renders the :new view template" do

      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token 
      response.should render_template :new      
    end
    it "sets @user with recipient's email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token 
      assigns(:user).email.should == invitation.recipient_email
    end 
    it "redirects to expired token page for invalid tokens" do 
      get :new_with_invitation_token, token: 'asdfasdf'
      response.should redirect_to expired_token_path
    end

    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token 
      assigns(:invitation_token).should == invitation.token
    end
  end
end