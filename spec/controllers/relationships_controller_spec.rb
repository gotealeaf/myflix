require 'spec_helper'

describe RelationshipsController do 
  describe "GET index" do
    context "user follows one person" do
      it "sets @relationships to a current user's following relationship" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        relationship = Fabricate(:relationship, follower_id: alice.id, leader_id: bob.id)
        set_current_user(alice)
        get :index
        expect(assigns(:relationships)).to eq([relationship])
      end
    end

    context "user follows multiple people" do
      it "sets @relationships to array containing all of user's following relationships" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        charles = Fabricate(:user)
        relationship = Fabricate(:relationship, follower_id: alice.id, leader_id: bob.id)
        relationship2 = Fabricate(:relationship, follower_id: alice.id, leader_id: charles.id)
        set_current_user(alice)
        get :index
        expect(assigns(:relationships)).to eq([relationship, relationship2])
      end
    end

    context "unauthenticated user" do
      before { get :index }

      it "does not set @relationships" do
        expect(assigns(:relationships)).to be_nil
      end

      it_behaves_like "requires login"
    end
  end

  describe "POST create" do
    context "the current user has not followed the person" do
      it "causes the current user to gain the clicked-on user as a leader" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(alice)
        post :create, leader_id: 2
        expect(alice.leaders.first).to eq(bob)
        expect(alice.leaders.count).to eq(1)
      end
      
      it "causes the clicked-on user to gain the current user as a follower" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(alice)
        post :create, leader_id: 2
        expect(alice.follows?(bob)).to be_true
        expect(bob.followers.count).to eq(1)
      end

      it "flashes a success message containing the followed user's name" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(alice)
        post :create, leader_id: 2
        expect(flash[:success]).to eq("You have followed #{bob.full_name}")
      end

      it "redirects to the current user's people page" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(alice)
        post :create, leader_id: 2
        expect(response).to redirect_to people_path
      end
    end

    context "the current user has already followed the person" do
      it "does not allow a user to follow the person again" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(alice)
        Fabricate(:relationship, leader_id: bob.id, follower_id: alice.id)
        post :create, leader_id: 2
        expect(alice.leaders.count).to eq(1)
      end

      it "shows an error message" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(alice)
        Fabricate(:relationship, leader_id: bob.id, follower_id: alice.id)
        post :create, leader_id: 2
        expect(assigns(:relationship).errors.empty?).to be_false
      end

      it "renders the person's profile page" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(alice)
        Fabricate(:relationship, leader_id: bob.id, follower_id: alice.id)
        post :create, leader_id: 2
        expect(response).to render_template 'users/show'
      end
    end

    context "the current user tries to follow themselves" do
      it "does not allow the user to follow themself" do
        alice = Fabricate(:user)
        set_current_user(alice)
        post :create, leader_id: 1
        expect(alice.leaders.count).to eq(0)
      end

      it "shows an error message" do
        alice = Fabricate(:user)
        set_current_user(alice)
        post :create, leader_id: 1
        expect(assigns(:relationship).errors.empty?).to be_false
      end

      it "renders the user's profile page" do
        alice = Fabricate(:user)
        set_current_user(alice)
        post :create, leader_id: 1
        expect(response).to render_template 'users/show'
      end
    end

    context "user is not authenticated" do
      before do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        post :create, leader_id: 2
      end

      it "does not create a new relationship" do
        expect(User.first.leaders.count).to eq(0)
      end

      it_behaves_like "requires login"
    end
  end

  describe "DELETE destroy" do
    context "the current user has followed the person" do
      it "deletes the user from the leader's follower list" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        alice.follow!(bob)
        set_current_user(alice)
        post :destroy, id: 1
        expect(bob.followers.count).to eq(0)
      end

      it "deletes the leader from the user's list" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        alice.follow!(bob)
        set_current_user(alice)
        post :destroy, id: 1
        expect(alice.leaders.count).to eq(0)
      end

      it "renders the show template" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        alice.follow!(bob)
        set_current_user(alice)
        post :destroy, id: 1
        expect(response).to redirect_to people_path
      end
    end

    context "the current user has not followed the person" do
      it "does not affect the leader's follower list" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        charles = Fabricate(:user)
        charles.follow!(bob)
        set_current_user(alice)
        post :destroy, id: 1
        expect(bob.followers.count).to eq(1)
      end

      it "does not affect the user's leader list" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        charles = Fabricate(:user)
        charles.follow!(bob)
        alice.follow!(charles)
        set_current_user(alice)
        post :destroy, id: 1
        expect(alice.leaders.count).to eq(1)
      end

      it "renders the people index" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        charles = Fabricate(:user)
        charles.follow!(bob)
        alice.follow!(charles)
        set_current_user(alice)
        post :destroy, id: 1
        expect(response).to redirect_to people_path
      end
    end

    context "user is not authenticated" do
      before do 
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        alice.follow!(bob)
        post :destroy, id: 1
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