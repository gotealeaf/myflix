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
end 