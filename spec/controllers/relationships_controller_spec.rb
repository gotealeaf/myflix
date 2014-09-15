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
  
end