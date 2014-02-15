require "spec_helper"

describe FriendsController do
  describe "GET new" do
    it_behaves_like "require sign in" do
      let(:action) { get :new }
    end
    it "creates an instance variable" do
      set_current_user
      get :new
      expect(assigns(:friend)).to be_new_record
      expect(assigns(:friend)).to be_instance_of Friend
    end
  end
  describe "POST create" do
    it_behaves_like "require sign in" do
      let(:action) { post :create }
    end
    context "valid input" do
      before { ActionMailer::Base.deliveries.clear }
      before { set_current_user }
      it "redirects user to the Invite a Friend page" do
        post :create, friend: {full_name: "Alice Humperdink", email: "alice@example.com", message: "I want to be your friend."}
        expect(response).to redirect_to new_friend_path
      end
      it "creates a new friend" do
        post :create, friend: {full_name: "Alice Humperdink", email: "alice@example.com", message: "I want to be your friend."}
        expect(Friend.count).to eq(1)
      end
      it "sends an email to the friend" do
        post :create, friend: {full_name: "Alice Humperdink", email: "alice@example.com", message: "I want to be your friend."}
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
      it "creates a Flash message confirming that the friend has been invited" do
        post :create, friend: {full_name: "Alice Humperdink", email: "alice@example.com", message: "I want to be your friend."}
        expect(flash[:success]).to eq("Alice Humperdink has been invited to be your friend!")
      end
    end
    context "invalid input" do
      before { ActionMailer::Base.deliveries.clear }
      before { set_current_user }
      it "renders the Invite a Friend page" do
        post :create, friend: {full_name: "Alice Humperdink", email: "alice@example.com"}
        expect(response).to render_template :new
      end
      it "displays a Flash message indicating what input is invalid" do
        post :create, friend: {full_name: "Alice Humperdink", email: "alice@example.com"}
        expect(flash[:error]).to eq("Please fix the errors below:")
      end
      it "should not allow a member to invite himself to be a member" do
        current_user = User.find(session[:user_id])
        post :create, friend: {full_name: "Alice Humperdink", email: current_user.email, message: "hello"}
        expect(flash[:error]).to eq("You can't invite yourself to be a member.")
      end
    end
  end
end