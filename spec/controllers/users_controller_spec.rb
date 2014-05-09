require 'spec_helper'

describe UsersController do 
  describe "GET new" do
    it "sets @user variable" do
      get :new
      expect(assigns :user).to be_instance_of User
    end
  end

  
  describe "POST create" do
    context "with valid input" do
      
      before { post :create, user: { email: "paq@paq.com", full_name: "paquito_spec", password: "password", password_confirmation: "password" } }
      after { ActionMailer::Base.deliveries.clear }
      
      it "creates the user" do
        User.first.email.should == "paq@paq.com"
        User.first.full_name.should == "paquito_spec"
      end

      it "redirect to sign_in path" do
        response.should redirect_to :sign_in
      end

      it "sends out the email" do
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends to the right recipient" do
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(["paq@paq.com"])
      end

      it "has the right content" do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("Welcome to Myflix paquito_spec!")
      end       
    end

    context "with invalid input" do
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

  describe "POST forgot_password" do
    context "with a valid email address" do
      before do
        Fabricate :user, full_name: "ana", email: "paq@paq.com"
        post :forgot_password, email: "paq@paq.com"
      end   

      let(:ana) { User.last }  

      after { ActionMailer::Base.deliveries.clear }
            
      it "redirects to sign in page page with a valid email address" do
        expect(response).to redirect_to sign_in_path
      end

      it "sends out the email" do
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends an email to the submited valid address" do 
        expect(ActionMailer::Base.deliveries.last.to).to eq(["paq@paq.com"])
      end

      it "sends an email with the user's name in the boby" do 
        expect(ActionMailer::Base.deliveries.last.body).to include("ana")
      end

      it "sends an email with the correct url to reset the password including the token" do
        expect(ActionMailer::Base.deliveries.last.body).to include("localhost:3000/reset_password?id=#{ana.token}")
      end

      it "sets reset_password_email_sent_at with the current datetime" do
        expect(ana.reset_password_email_sent_at).to eq(ActionMailer::Base.deliveries.last.date)
      end
    end

    context "with an email that does not belong to any registered user" do
      it "renders forgot_password template" do
        post :forgot_password, email: "paq@paq.com"
        expect(response).to render_template :forgot_password
      end 

      it "sets the error" do
        post :forgot_password, email: "paq@paq.com"  
        expect(flash[:error]).to_not be_blank
      end

      it "does not send an email" do 
        post :forgot_password, email: "paq@paq.com" 
        expect(ActionMailer::Base.deliveries.last).to be_nil
      end
    end

    describe "GET reset_password" do
      it "redirects to sign in page if the password is saved"
      it "redirects to sign in page if user's reset_password_email_sent_at is more than 24 hours the current time"
      it "saves the new user's password"
      it "does not save password with less characters than 8"
      
    end
  end
end 