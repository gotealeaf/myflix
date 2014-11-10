require 'spec_helper'

describe UsersController do
  
  describe "GET new" do
    it "sets @user to a new User object" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  
  describe "POST create" do
    context "email sending" do
      before { ActionMailer::Base.deliveries.clear }
      after { ActionMailer::Base.deliveries.clear }
      
      it "sends out the email to the user with valid inputs" do
        post :create, user: { email: "dcprime@gmail.com", password: "password", full_name: "Dave Conley" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["dcprime@gmail.com"])
      end
      it "sends the email containing the user's name with valid inputs" do
        post :create, user: { email: "dcprime@gmail.com", password: "password", full_name: "Dave Conley" }
        expect(ActionMailer::Base.deliveries.last).to have_content("Dave Conley")
      end
      it "does not send the email with invalid inputs" do 
        post :create, user: { email: "dcprime@gmail.com", full_name: "Dave Conley" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
    
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      it "redirects to sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end
    
    context "with invalid input" do
      before do
        post :create, user: {email: "dcprime@gmail.com", password: "password"}
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
    
    context "with friend invite" do
      it "creates a Relationship where the inviter follows the friend" do
        darren = Fabricate(:user)
        invitation = Fabricate(:invitation, user_id: darren.id)
        invitation.update_column(:token, '12345')
        post :create, user: { email: invitation.friend_email, password: "password", full_name: "Alice Smith" }
        expect(darren.following_users.last.full_name).to eq("Alice Smith")
      end
      it "creates a Relationship where the friend follows the invitor" do
        darren = Fabricate(:user)
        invitation = Fabricate(:invitation, user_id: darren.id)
        invitation.update_column(:token, '12345')
        post :create, user: { email: invitation.friend_email, password: "password", full_name: "Alice Smith" }
        expect(User.find_by(full_name: "Alice Smith").following_users.last).to eq(darren)
      end
    end
  end
  
  describe "GET show" do
    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: 5 }
    end
    it "sets @user" do
      set_current_user
      get :show, id: current_user.id
      expect(assigns(:user)).to eq(current_user)
    end
  end
  
  describe "GET following" do
    it_behaves_like "require_sign_in" do
      let(:action) { get :following }
    end
  end
  
  describe "POST follow" do
    it_behaves_like "require_sign_in" do
      let(:action) { post :follow, id: 3 }
    end
    it "adds the user to the current_user's following_users" do
      darren = Fabricate(:user)
      set_current_user(darren)
      larissa = Fabricate(:user)
      post :follow, id: larissa.id
      expect(darren.following_users.first).to eq(larissa)
    end
    it "redirects to the following page" do
      darren = Fabricate(:user)
      set_current_user(darren)
      larissa = Fabricate(:user)
      post :follow, id: larissa.id
      expect(response).to redirect_to following_path
    end
    it "renders the show page after invalid requests" do
      darren = Fabricate(:user)
      set_current_user(darren)
      post :follow, id: darren.id
      expect(response).to render_template(:show)
    end
  end
  
  describe "POST unfollow" do
    it_behaves_like "require_sign_in" do
      let(:action) { post :unfollow, id: 2 }
    end
    context "with valid input" do
      it "removes the user from the current_user's following_users" do
        darren = Fabricate(:user)
        set_current_user(darren)
        larissa = Fabricate(:user)
        darren.following_users << larissa
        post :unfollow, id: larissa.id
        expect(darren.following_users.count).to eq(0)
      end
      it "redirects to the following page" do
        darren = Fabricate(:user)
        set_current_user(darren)
        larissa = Fabricate(:user)
        darren.following_users << larissa
        post :unfollow, id: larissa.id
        expect(response).to redirect_to following_path
      end
    end
    context "with invalid input" do
      it "does not remove the user from another user's following_users" do
        darren = Fabricate(:user)
        set_current_user(darren)
        larissa = Fabricate(:user)
        charles = Fabricate(:user)
        charles.following_users << larissa
        post :unfollow, id: larissa.id
        expect(charles.following_users.first).to eq(larissa)
      end
      it "renders to the following page" do
        darren = Fabricate(:user)
        set_current_user(darren)
        larissa = Fabricate(:user)
        charles = Fabricate(:user)
        charles.following_users << larissa
        post :unfollow, id: larissa.id
        expect(response).to render_template :following
      end
    end
  end
  
end