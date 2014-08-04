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
    context "successful signup" do
      it "redirect to sign_in path" do
        result = double(:sign_up_result, successful?: true)
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)

        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        response.should redirect_to :sign_in
      end
    end

    context "failed user sign up" do
      before do
        result = double(:sign_up_result, successful?: false, error_message: "Error message.")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
      end

      it "renders the new template" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        expect(response).to render_template :new
      end

      it "sets the flash error message" do
        post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" }
        expect(flash[:error]).to be_present
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