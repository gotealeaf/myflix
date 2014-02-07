require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it "creates a new User object" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
    it "renders the Register page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET show' do
    it "should have a user object" do
      set_current_user
      user = Fabricate(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
    it_behaves_like "require sign in" do
      let(:action) { get :show, id: 1 }
    end
  end

  describe 'POST create' do
    context "with valid input" do
      before { create_user_valid_credentials }
      it "creates a new user" do
        expect(User.count).to eq(1)
      end
      it "redirects to the root" do
        expect(response).to redirect_to root_path
      end
      it "creates a new session" do
        post :create, user: {email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger'}
        expect(session[:user_id]).not_to eq nil
      end
    end
    context "with invalid input" do
      before { create_user_invalid_credentials }
      it "does not create a new user" do
        expect(User.count).to eq(0)
      end
      it "renders the new template again" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
    context "email sending" do
      before { ActionMailer::Base.deliveries.clear }
      it "sends out the email" do
        post :create, user: {email: 'alice@example.com', password: 'alice', full_name: 'Alice Humperdink'}
        ActionMailer::Base.deliveries.should_not be_empty
      end
      it "sends to the right recipient" do
        post :create, user: {email: 'alice@example.com', password: 'alice', full_name: 'Alice Humperdink'}
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(['alice@example.com'])
      end
      it "has the right content" do
        post :create, user: {email: 'alice@example.com', password: 'alice', full_name: 'Alice Humperdink'}
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include('Alice Humperdink')
      end
      it "does not send an email if the user record is invalid" do
        post :create, user: {email: 'alice@example.com', password: 'alice', full_name: ''}
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
  end

  private

  def create_user_valid_credentials
    post :create, user: Fabricate.attributes_for(:user)
  end

  def create_user_invalid_credentials
    post :create, user: { password: 'joelevinger', full_name: 'Joe Levinger' }
  end
end