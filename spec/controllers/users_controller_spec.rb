require 'spec_helper'

describe UsersController do
  
  describe "GET new" do
    it "sets the @user variable" do 
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    after { ActionMailer::Base.deliveries.clear }
    context "with valid input" do 
      before do 
        post :create, user: Fabricate.attributes_for(:user)
      end
      it "creates the user" do 
        expect(User.count).to eq(1)
      end
     end

    context "email sending" do 
      
      it "sends out the email" do 
        post :create, user: { email: "arjun@example.com", password: "arjun", full_name: "Arjun Rajkumar" }
        ActionMailer::Base.deliveries.should_not be_empty
      end
      it "sends to the right recipient" do 
        post :create, user: { email: "arjun@example.com", password: "arjun", full_name: "Arjun Rajkumar" }
        message = ActionMailer::Base.deliveries.last
        message.to.should == ["arjun@example.com"]
      end
      it "has the right content" do 
        post :create, user: { email: "arjun@example.com", password: "arjun", full_name: "Arjun Rajkumar" }
        message = ActionMailer::Base.deliveries.last
        message.body.should include "Arjun Rajkumar"
      end
      it "does not send out email with invalid inputs" do 
        post :create, user: { email: "arjun@example.com", full_name: "Arjun Rajkumar" }
        ActionMailer::Base.deliveries.should be_empty
      end
    end
     
      it_behaves_like "requires sign in" do 
      let(:action) { post :create, user: Fabricate.attributes_for(:user) }
    end
    

    context "with invalid input" do 
      before do
        post :create, user: { email: "arjun@arjun.arjun", 
          password: "password"}
      end
      it "does not save user" do 
        expect(User.count).to eq(0)
      end 
      it "renders the new template" do 
        expect(response).to render_template :new
      end
      it "sets @user" do 
        expect(assigns(:user)).to be_instance_of(User)
      end 
    end
  end

end
