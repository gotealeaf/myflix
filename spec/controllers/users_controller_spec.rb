require 'rails_helper.rb'

describe UsersController do

  describe "GET new" do
    it "sets new @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    let (:user) { Fabricate(:user) }

    context "with valid input data" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to videos_path" do
        expect(response).to redirect_to videos_path
      end
    end

    context "with invalid input data" do
      before do
        post :create, user: { password: "password", full_name: "Josh Leeman}" }
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "sets new @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "email sending" do
      before do
        post :create, user: { password: "password", full_name: "Joe Smith", email: "joesmith@gmail.com" }
      end

      it "sends out an email" do
        expect(ActionMailer::Base.deliveries).not_to eq(nil)
      end

      it "sends out to right recipient" do
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(["joesmith@gmail.com"])
      end

      it "sends the correct content" do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("Welcome to MyFlix, Joe Smith!")
      end
    end
  end

  describe "GET show" do
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: 3 }
    end

    it "sets @user" do
      set_current_user
      joe = Fabricate(:user)
      get :show, id: joe.id
      expect(assigns(:user)).to eq(joe)
    end
  end
end
