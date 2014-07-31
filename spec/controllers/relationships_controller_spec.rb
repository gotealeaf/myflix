require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    it "sets @relationships to the current user's following relationships" do
      lalaine = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(lalaine)
      relationship = Fabricate(:relationship, follower: lalaine, leader: bob)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end

    it_behaves_like "requires sign in" do
      let(:action) {get :index}
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) {get :create, id: 4}
    end
    it "redirects to the people page" do
      lalaine = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(lalaine)
      post :create, leader_id: bob.id
      expect(response).to redirect_to people_path
    end
    it "creates a relationship that the current user follows the leader" do
      lalaine = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(lalaine)
      post :create, leader_id: bob.id
      expect(lalaine.following_relationships.first.leader).to eq(bob)
    end 
    
    it "does not create the relationship if the current user already follows the leader" do
      lalaine = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(lalaine)
      Fabricate(:relationship, follower: lalaine, leader: bob)
      post :create, leader_id: bob.id
      expect(Relationship.count).to eq(1)
    end
    it "does not alow one to follow themself" do
      lalaine = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(lalaine)
      post :create, leader_id: lalaine.id
      expect(Relationship.count).to eq(0)
    end
  end
  describe "DELETE destroy" do
    it_behaves_like "requires sign in" do
      let(:action) {get :destroy, id: 3}
    end
    it "redirects to the people page" do
      lalaine = Fabricate(:user)
      set_current_user(lalaine)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: lalaine, leader: bob)
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end
    it "deletes the relationship if the current user is the follower" do
      lalaine = Fabricate(:user)
      set_current_user(lalaine)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: lalaine, leader: bob)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end
    
    it "does not delete the relationsip if if the current user in not the follower" do
      lalaine = Fabricate(:user)
      set_current_user(lalaine)
      bob = Fabricate(:user)
      charlie = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: charlie, leader: bob)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end

  end
end