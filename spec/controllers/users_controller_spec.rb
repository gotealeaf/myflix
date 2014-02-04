
 require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  
  describe "POST create" do
    context "with valid input" do

      before { post :create, user: Fabricate.attributes_for(:user) }
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      it "redirects to the root page" do
        expect(response).to redirect_to root_path 
      end
    end

    context "with incalid input" do

      before do
        post :create, user: { password: "password", full_name: "Kevin Wang" }
      end
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "render the :new template" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "sending email" do

      after { ActionMailer::Base.deliveries.clear }

      it "sends out email to user with  valid input" do
        post :create, user: { email: "jenny@example.com", password: "password", full_name: "Jenny" } 
        expect(ActionMailer::Base.deliveries.last.to).to eq(['jenny@example.com'])
      end
      it "sends out email containing the user's name with valid input" do
        post :create, user: { email: "jenny@example.com", password: "password", full_name: "Jenny" } 
        expect(ActionMailer::Base.deliveries.last.body).to include('Jenny')
      end
      it "does not sends email to user with invalid input" do
        post :create, user: { password: "password", full_name: "Jenny" } 
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end
