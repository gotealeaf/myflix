require 'spec_helper'

describe UsersController do 
  describe "GET new" do
    it "sets @user variable" do
      get :new
      expect(assigns :user).to be_instance_of User
    end
   
    it "sets @token variable with nil if there is no token passed via url" do
      get :new
      expect(assigns :token).to be_nil
    end 

    it "does not sets @tuser email if there is no email passed via url" do
      get :new
      expect(assigns(:user).email).to be_nil
    end     
  end

  
  describe "POST create" do
    context "with valid personal info and valid card" do
      let(:charge) { double(:charge, successful?: true) }
      before { StripeWrapper::Charge.should_receive(:create).and_return(charge) }
      after { ActionMailer::Base.deliveries.clear }
      
      it "creates the user" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }

        User.first.email.should == "paq@paq.com"
        User.first.full_name.should == "paquito_spec"
      end

      it "redirect to sign_in path" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        response.should redirect_to :sign_in
      end

      it "sends out the email" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends to the right recipient" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(["paq@paq.com"])
      end

      it "has the right content" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("Welcome to Myflix paquito_spec!")
      end       

      it "does not create a bidirectional relationship between the user and the invited user" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        expect(User.last.followers.count).to eq(0)
      end

      context "from an invitation" do
        it "creates a bidirectional relationship between the user and the invited user" do
          ana = Fabricate :user
          invitation = Fabricate :invitation, inviter: ana, recipient_email: "paq@paq.com"

          post :create, invitation_token: invitation.token, user: { email: invitation.recipient_email, full_name: invitation.recipient_name, password: "password", password_confirmation: "password" }
        
          expect(ana.follows? User.last).to be_true
          expect(User.last.follows? ana).to be_true
        end

        it "expires the token" do
          ana = Fabricate :user
          invitation = Fabricate :invitation, inviter: ana, recipient_email: "paq@paq.com"

          post :create, invitation_token: invitation.token, user: Fabricate.attributes_for(:user), estripe_token: '123456'
        
          expect(Invitation.last.token).to be_nil
        end
      end
    end

    context "valid personal info and declines card" do
      let(:charge) { double(:charge, successful?: false, error_message: "Your card was declined") }
      before { StripeWrapper::Charge.should_receive(:create).and_return(charge) }

      it "renders the new template" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        expect(response).to render_template :new
      end

      it "does not create a new user record" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        expect(User.count).to eq(0)
      end

      it "sets the flash error message" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        expect(flash[:error]).to be_present
      end
    end

    context "with invalid personal info" do
      before { post :create, user: { full_name: "paquito_spec", password: "password", password_confirmation: "password" } }
    
      after { ActionMailer::Base.deliveries.clear }

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "renders :new template when the input is incorrect" do
        response.should render_template :new
      end

      it "does not send an email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "does not charge the credit card" do
        StripeWrapper::Charge.should_not_receive(:create)

      end
    end
  end

  describe "GET show" do
    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: 3  }
    end

    it "set @user with authenticated user" do
      ana = Fabricate :user
      set_current_user ana
     
      get :show, id: ana.token

      expect(assigns :user).to eq(ana)
    end
  end 

  describe "new_with_invitation_token" do
    it "renders new template with valid tokens" do
      invitation = Fabricate :invitation      
      get :new_with_invitation_token, token: invitation.token
      
      expect(response).to render_template :new
    end

    it "sets @invitation_token" do
      invitation = Fabricate :invitation      
      get :new_with_invitation_token, token: invitation.token
      
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it "sets @user with recipient's email" do
      invitation = Fabricate :invitation      
      get :new_with_invitation_token, token: invitation.token
      
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end
    
    it "redirects to expired token page with invalid tokens" do
      get :new_with_invitation_token, token: "jodiejwd"    
      expect(response).to redirect_to expired_token_path
    end
  end
end 