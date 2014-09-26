require 'spec_helper'

describe UsersController do

  let(:hank)  { Fabricate(:user) }

#######################################################

  describe 'GET show' do
    it_behaves_like "require_sign_in" do
      let(:action) {get :show, id: 1}
    end

    it "prepares the user instance variable" do
      set_current_user(hank)
      get :show, id: hank.id
      expect(assigns(:user)).to eq(hank)
      end
  end

#######################################################
  describe 'GET new_with_invitation_token' do

  context "the token is valid" do 
    it "renders new" do
      invitation = Fabricate(:invitation, inviter: hank)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end

    it "fills in the invitees email with valid token" do
      #invitation = Invitation.create(recipient_email: 'rick.heller@yahoo.com', recipient_name: 'Joe', message: 'hi', inviter: hank)
      invitation = Fabricate(:invitation, inviter: hank)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end
  end

  
  it "redirects with INvalid token" do
    get :new_with_invitation_token, token: "fake"
    expect(response).to redirect_to invalid_token_path
  end

end
#######################################################
  describe 'GET new' do
    it "generates a new record" do
      get :new
      assigns(:user).should be_instance_of(User)
    end
  end


#######################################################
  describe 'POST create' do
 
    context "the user sign up is valid" do
   
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      after do
        #unlike the test database, RSpec does not automatically clear the mail queue
        ActionMailer::Base.deliveries.clear
      end


      it "generates a user from valid data" do
        User.count.should == 1
      end

      it "redirects to sign_in" do
        response.should redirect_to sign_in_path
      end

      it "sends a welcome email " do
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
      
      it "checks if the email is addressed to the right person" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(["rick.heller@yahoo.com"])
      end

      it "has the correct content" do
        expect(ActionMailer::Base.deliveries.last.body).to include("Welcome")
      end

    end


    context "the user sign up is INVALID" do

      before do
        post :create, user: {email: "", password: "", full_name: ""}
      end

      it "renders redirect to sign_in" do
        response.should render_template :new
      end
      it "does NOT generate a user" do
        User.count.should == 0
      end
      it "DOES NOT send a welcome email " do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
      it "regenerates a user record for another try" do
        assigns(:user).should be_instance_of(User)
      end
    end

  end
##############################################

end
