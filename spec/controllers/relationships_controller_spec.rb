require 'spec_helper'

describe RelationshipsController do 
  describe "GET show" do
    before do
      alice = Fabricate(:user)
    end

    it "sets @user" do
      set_current_user(User.find(1))
      get :show, id: User.first
      expect(assigns(:user)).to be_instance_of(User)
      expect(assigns(:user)).to eq(User.first)
    end

    context "unauthenticated user" do
      before { get :show, id: User.first }

      it "does not set @user" do
        expect(assigns(:user)).not_to be_instance_of(User)
      end

      it_behaves_like "requires login"
    end

    context "submitted id is not current user's id" do
      before do
        set_current_user(User.find(1))
        bob = Fabricate(:user)
        get :show, id: User.find(2).id
      end

      it "does not set @user" do
        expect(assigns(:user)).not_to be_instance_of(User)
      end

      it_behaves_like "requires login"
    end
  end

  describe "POST create" do
    context "the current user has not followed the person" do
      before do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(User.first)
        post :create, user_id: 2
      end

      it "causes the current user to gain clicked-on user as a leader" do
        expect(User.first.leaders.first).to eq(User.find(2))
        expect(User.first.leaders.count).to eq(1)
      end
      
      it "causes the clicked-on user to gain the current user as a follower" do
        expect(User.find(2).followers.first).to eq(User.first)
        expect(User.find(2).followers.count).to eq(1)
      end

      it "flashes a success message containing the followed user's name" do
        expect(flash[:success]).to eq("You have followed #{User.find(2).full_name}")
      end

      it "redirects to the current user's people page" do
        expect(response).to redirect_to relationship_path(User.first)
      end
    end

    context "the current user has already followed the person" do
      before do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(User.first)
        Fabricate(:relationship, user_id: 2, follower_id: 1)
        post :create, user_id: 2
      end

      it "does not allow a user to follow the person again" do
        expect(User.first.leaders.count).to eq(1)
      end

      it "shows an error message" do
        expect(assigns(:new_relationship).errors.empty?).to be_false
      end

      it "renders the person's profile page" do
        expect(response).to render_template 'users/show'
      end
    end

    context "the current user tries to follow themselves" do
      before do
        alice = Fabricate(:user)
        set_current_user(User.first)
        post :create, user_id: 1
      end

      it "does not allow the user to follow themself" do
        expect(User.first.leaders.count).to eq(0)
      end

      it "shows an error message" do
        expect(assigns(:new_relationship).errors.empty?).to be_false
      end

      it "renders the user's profile page" do
        expect(response).to render_template 'users/show'
      end
    end

    context "user is not authenticated" do
      before do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        post :create, user_id: 2
      end

      it "does not create a new relationship" do
        expect(User.first.leaders.count).to eq(0)
      end

      it_behaves_like "requires login"
    end
  end

  describe "DELETE destroy" do
    context "the current user has followed the person" do
      before do 
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        Fabricate(:relationship, user_id: 2, follower_id: 1)
        set_current_user(alice)
        post :destroy, leader_id: 2, id: 1
      end

      it "deletes the user from the leader's follower list" do
        expect(User.find(2).followers.count).to eq(0)
      end

      it "deletes the leader from the user's list" do
        expect(User.first.leaders.count).to eq(0)
      end

      it "renders the show template" do
        expect(response).to redirect_to relationship_path
      end
    end

    context "the current user has not followed the person" do
      before do 
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        charles = Fabricate(:user)
        Fabricate(:relationship, user_id: 2, follower_id: 3)
        Fabricate(:relationship, user_id: 3, follower_id: 1)
        set_current_user(alice)
        post :destroy, leader_id: 2, id: 1
      end

      it "does not affect the leader's follower list" do
        expect(User.find(2).followers.count).to eq(1)
      end

      it "does not affect the user's leader list" do
        expect(User.first.leaders.count).to eq(1)
      end

      it "renders the show template" do
        expect(response).to redirect_to relationship_path
      end
    end

    context "user is not authenticated" do
      before do 
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        Fabricate(:relationship, user_id: 2, follower_id: 1)
        post :destroy, leader_id: 2, id: 1
      end

      it "does not affect the leader's follower list" do
        expect(User.find(2).followers.count).to eq(1)
      end
      
      it "does not affect the user's leader list" do
        expect(User.first.leaders.count).to eq(1)
      end

      it_behaves_like "requires login"
    end
  end
end