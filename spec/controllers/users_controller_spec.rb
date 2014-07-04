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
      after { ActionMailer::Base.deliveries.clear }

      it "sends out an email to user with valid inputs" do
        post :create, user: { email: "joe@gmail.com", password: "password", full_name: "Joe Smith"}
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@gmail.com"])
      end

      it "sends email body content including users's name with valid inputs" do
        post :create, user: { email: "joe@gmail.com", password: "password", full_name: "Joe Smith"}
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("Welcome to MyFlix, Joe Smith!")
      end

      it "does not send email with invalid inputs" do
        post :create, user: { password: "password", full_name: "Joe Smith"}
        message = ActionMailer::Base.deliveries.last
        expect(message).to eq(nil)
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
