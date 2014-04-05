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

      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to sign_in_path" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid input" do

      before do
        post :create, user: {email: "mat@fat.com"}
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "sending emails" do

      after { ActionMailer::Base.deliveries.clear }

      it "sends out email to the user with valid inputs" do
        post :create, user: { email: "amanda@example.com", password: "password", full_name: "Amanda Sander"}
        expect(ActionMailer::Base.deliveries.last.to).to eq(['amanda@example.com'])
      end

      it "sends out email containing the user's name with valid inputs" do
        post :create, user: { email: "amanda@example.com", password: "password", full_name: "Amanda Sander"}
        expect(ActionMailer::Base.deliveries.last.body).to include('Amanda Sander')
      end

      it "does not send out email with invalid inputs" do
        post :create, user: { email: "amanda@example.com"}
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end   

  describe "GET show" do
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: 3}
    end

    it "sets @user" do
      set_current_user
      amanda = Fabricate(:user)
      get :show, id: amanda.id
      expect(assigns(:user)).to eq(amanda)
    end
  end
end