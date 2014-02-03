require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    it "sets @Relationships to the current user's following relationships" do
      sam = Fabricate(:user)
      set_current_user(sam)
      vivian = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: sam, leader: vivian)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 4 }
    end
    
    it "redirect to the people page" do
      sam = Fabricate(:user)
      set_current_user(sam)
      vivian = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: sam, leader: vivian)
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end

    it "it delete the relationship if the current user is the follower" do
      sam = Fabricate(:user)
      set_current_user(sam)
      vivian = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: sam, leader: vivian)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end

    it "does not delete the relationship if the current user is not the follower" do
      sam = Fabricate(:user)
      neil = Fabricate(:user)
      set_current_user(neil)
      vivian = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: sam, leader: vivian)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create, leader_id: 3 }
    end

    it "redirect to the people page" do
      sam = Fabricate(:user)
      set_current_user(sam)
      vivian = Fabricate(:user)
      post :create, leader_id: vivian.id
      expect(response).to redirect_to people_path
    end

    it "creates a relationship that current_user follows the leader" do
      sam = Fabricate(:user)
      set_current_user(sam)
      vivian = Fabricate(:user)
      post :create, leader_id: vivian.id
      expect(sam.following_relationships.first.leader).to eq(vivian)
    end

    it "does not create relationship if current_user have follows the leader" do
      sam = Fabricate(:user)
      set_current_user(sam)
      vivian = Fabricate(:user)
      Fabricate(:relationship, leader: vivian, follower: sam)
      post :create, leader_id: vivian.id
      expect(Relationship.count).to eq(1)
    end

    it "does not allow one to follow themselves" do
      sam = Fabricate(:user)
      set_current_user(sam)
      post :create, leader_id: sam.id
      expect(Relationship.count).to eq(0)
    end
  end
end
