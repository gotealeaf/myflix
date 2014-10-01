require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    it "sets @relationships to the current user's following relationships" do
      karen = Fabricate(:user)
      set_current_user(karen)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: karen, leader: bob)
      get :index
      assigns(:relationships).should == [relationship]
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
    end
  end
  describe "DELETE destroy" do
    it "deletes the current user's relationship" do
      karen = Fabricate(:user)
      set_current_user(karen)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: karen, leader: bob)
      delete :destroy, id: relationship
      Relationship.count.should == 0
    end

    it "redirects to the people page" do
      karen = Fabricate(:user)
      set_current_user(karen)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: karen, leader: bob)
      delete :destroy, id: relationship
      response.should redirect_to people_path
    end

    it "does not delete the relationship if the current user is not a follower" do
      karen = Fabricate(:user)
      melissa = Fabricate(:user)
      set_current_user(melissa)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: karen, leader: bob)
      delete :destroy, id: relationship
      Relationship.count.should == 1
    end

    it_behaves_like "require_sign_in" do
      let(:action) { delete :destroy, id: 4 }
    end
  end
  describe "POST create" do
    it_behaves_like "require_sign_in" do
      let(:action) { post :create, leader_id: 3 }
    end

    it "creates a relationship with the current user" do
      karen = Fabricate(:user) 
      set_current_user(karen)
      bob = Fabricate(:user)
      post :create, leader_id: bob.id 
      karen.following_relationships.first.leader.should == bob
    end
    it "redirects to the people page " do
      karen = Fabricate(:user) 
      set_current_user(karen)
      bob = Fabricate(:user)
      post :create, leader_id: bob.id 
      response.should redirect_to people_path
    end

    it "does not allow current user to follow leader twice" do
      karen = Fabricate(:user) 
      set_current_user(karen)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: karen, leader: bob)
      post :create, leader_id: bob.id 
      Relationship.count.should == 1
    end
    it "does not allow a user to follow themselves" do
      karen = Fabricate(:user)
      set_current_user(karen)
      post :create, leader_id: karen.id 
      Relationship.count.should == 0
    end
  end 
end