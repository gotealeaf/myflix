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
      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with invalid input" do
      before do
        post :create, user: { password: "password", full_name: "Jim Brown" }
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
        post :create, user: { email: "angus@example.com", password: "password", full_name: "Angus MacDoogan" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(['angus@example.com'])
      end
      it "sends out email with the user's name with valid inputs" do
        post :create, user: { email: "angus@example.com", password: "password", full_name: "Angus MacDoogan" }
        expect(ActionMailer::Base.deliveries.last.body).to include("Angus MacDoogan")
      end
      it "does not send out email with invalid inputs" do
        post :create, user: { email: "angus@example.com" }
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
      alice = Fabricate(:user)
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end
end