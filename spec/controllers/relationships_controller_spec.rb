require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    it "sets the @relationships to the current users following relationships" do
      mark = Fabricate(:user)
      set_current_user(mark)
      bill = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: mark, leader: bill)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end

describe "DELETE destroy" do
  it_behaves_like "requires sign in" do
    let(:action) { delete :destroy, id: 4}
  end


    it "redirects to the people page" do
      mark = Fabricate(:user)
      set_current_user(mark)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: mark, leader: bob)
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end

    it "deletes the relationship if the current user if the follower" do
      mark = Fabricate(:user)
      set_current_user(mark)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: mark, leader: bob)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end


    it "does not delete the relationship if the current user is not the follower" do
      mark = Fabricate(:user)
      set_current_user(mark)
      bob = Fabricate(:user)
      bill = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: bill, leader: bob)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create, leader_id: 3 }
    end

    it "redirects to the people page" do
      mark = Fabricate(:user)
      bill = Fabricate(:user)
      set_current_user(mark)
      post :create, leader_id: bill.id
      expect(response).to redirect_to people_path
    end

    it "creates a relationship that the current user follows the leader" do
      mark = Fabricate(:user)
      bill = Fabricate(:user)
      set_current_user(mark)
      post :create, leader_id: bill.id
      expect(mark.following_relationships.first.leader).to eq(bill)
    end
    
    it "it does create a relationship if the current user already follows the leader" do
      mark = Fabricate(:user)
      bill = Fabricate(:user)
      set_current_user(mark)
      Fabricate(:relationship, follower: mark, leader: bill)
      post :create, leader_id: bill.id
      expect(Relationship.count).to eq(1)
    end
    
    it "it does not allow one to follow themselves" do
      mark = Fabricate(:user)
      set_current_user(mark)
      post :create, leader_id: mark.id
      expect(Relationship.count).to eq(0)
    end
  
  end
end