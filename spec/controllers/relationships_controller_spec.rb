require "spec_helper"

describe RelationshipsController do
  describe "GET index" do
    context "with authenticated users" do
      it "should set relationships for current user's following relationships" do
        desmond = Fabricate(:user)
        linda = Fabricate(:user)
        relationship = Fabricate(:relationship, follower: desmond, leader: linda)
        set_current_user(desmond)
        get :index
        expect(assigns(:relationships)).to eq([relationship])
      end
    end

    context "with unauthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { get :index }
      end
    end
  end

  describe "DELETE destroy" do
    context "with authenticated users" do
      it "should redirect to people page" do
        desmond = Fabricate(:user)
        linda = Fabricate(:user)
        relationship = Fabricate(:relationship, follower: desmond, leader: linda)
        set_current_user(desmond)
        delete :destroy, id: relationship.id
        expect(response).to redirect_to people_path
      end

      it "should delete relationship if the current user is the follower" do
        desmond = Fabricate(:user)
        linda = Fabricate(:user)
        relationship = Fabricate(:relationship, follower: desmond, leader: linda)
        set_current_user(desmond)
        delete :destroy, id: relationship.id
        expect(Relationship.count).to eq(0)
      end

      it "should not delete relationship if the current user is not the follower" do
        desmond = Fabricate(:user)
        linda = Fabricate(:user)
        bob = Fabricate(:user)
        relationship = Fabricate(:relationship, follower: bob, leader: linda)
        set_current_user(desmond)
        delete :destroy, id: relationship.id
        expect(Relationship.count).to eq(1)
      end
    end

    context "with unauthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { delete :destroy, id: 1 }
      end
    end
  end

  describe "POST create" do
    context "with authenticated users" do
      it "should redirect to people page" do
        desmond = Fabricate(:user)
        linda = Fabricate(:user)
        set_current_user(desmond)
        post :create, leader_id: linda.id
        expect(response).to redirect_to people_path
      end
      it "should create a relationship that current user follows the leader" do
        desmond = Fabricate(:user)
        linda = Fabricate(:user)
        set_current_user(desmond)
        post :create, leader_id: linda.id
        expect(desmond.following_relationships.first.leader).to eq(linda)
      end
      it "should not create a relationship if current user has already followed the leader" do
        desmond = Fabricate(:user)
        linda = Fabricate(:user)
        set_current_user(desmond)
        Relationship.create(follower: desmond, leader: linda)
        post :create, leader_id: linda.id
        expect(desmond.following_relationships.count).to eq(1)
      end
      it "should not follow current user himself" do
        desmond = Fabricate(:user)
        set_current_user(desmond)
        post :create, leader_id: desmond.id
        expect(desmond.following_relationships.count).to eq(0)
      end
    end

    context "with unauthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, leader_id: 1 }
      end
    end
  end
end
