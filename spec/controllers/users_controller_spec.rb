require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user to User.new" do
      get :new 
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "input is valid" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates a new user" do
        expect(assigns(:user)).to be_instance_of(User)
        expect(assigns(:user)).to be_valid
        expect(assigns(:user).save).to be_true
        expect(User.count).to eq(1)
      end

      it_behaves_like "requires login"
    end

    context "email sending" do
      it "sends out the email" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(ActionMailer::Base.deliveries).not_to be_empty
      end

      it "sends to the right recipient" do
        post :create, user: Fabricate.attributes_for(:user)
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([User.first.email])
      end

      it "has the right content" do
        post :create, user: Fabricate.attributes_for(:user)
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("Welcome to MyFlix, #{User.first.full_name}!")
      end
    end

    context "input is invalid" do
      before { post :create, user: Fabricate.attributes_for(:user, password: "") }
      
      it "does not save the user" do
        expect(assigns(:user)).to_not be_valid
        expect(assigns(:user).save).to_not be_true
        expect(User.count).to eq(0)
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "renders :new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET show" do
    before do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
    end

    it "sets @user" do
      set_current_user(User.find(1))
      get :show, id: User.find(2).id 
      expect(assigns(:user)).to be_instance_of(User)
    end

    context "unauthenticated user" do
      before { get :show, id: User.find(2).id }

      it "does not set @user" do
        expect(assigns(:user)).not_to be_instance_of(User)
      end

      it_behaves_like "requires login"
    end
  end
end