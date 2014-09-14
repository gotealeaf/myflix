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
end