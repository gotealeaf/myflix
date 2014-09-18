require 'spec_helper'

describe RelationshipsController do

  let(:hank) { Fabricate(:user) }
  let(:joe)  { Fabricate(:user) }


  describe 'GET index' do
    it_behaves_like "require_sign_in" do
      let(:action) {get :index}
    end

    it "prepares the instance variable" do
      set_current_user(hank)
      rel = Relationship.create(follower_id: hank.id, leader_id: joe.id)
      get :index
      expect(assigns(:leads)).to eq([rel])
    end
  end
##########################################################
  describe "POST create" do

    it_behaves_like "require_sign_in" do
      let(:action) {post :create, leader_id: joe.id}
    end

    it "redirects to the people page" do
      set_current_user(hank)
      post :create, leader_id: joe.id
      response.should redirect_to people_path
    end

    it "follows the user if not already followed" do
      set_current_user(hank)
      post :create, leader_id: joe.id
      expect(Relationship.count).to eq(1)
    end

    it "does not follows the user if already followed"  do
      set_current_user(hank)
      Relationship.create(leader: joe, follower:hank)
      post :create, leader_id: joe.id
      expect(Relationship.count).to eq(1)
    end

    it "does not follows itself" do
      set_current_user(hank)
      post :create, leader_id: hank.id
      expect(Relationship.count).to eq(0)
    end 

  end


##########################################################
  describe "delete destroy" do

    it_behaves_like "require_sign_in" do
      let(:action) {delete :destroy, id: 1}
    end

    it "removes the item if a follower" do
      set_current_user(hank)
      r1 = Fabricate(:relationship, leader_id: joe.id,  follower_id: hank.id)
      delete :destroy, id: r1.id
      expect(Relationship.count).to eq(0)
    end

    it "redirects to the people page" do
      set_current_user(hank)
      r1 = Fabricate(:relationship, leader_id: joe.id,  follower_id: hank.id)
      delete :destroy, id: r1.id
      response.should redirect_to people_path
    end

    it "does NOT removes the item" do
      set_current_user(hank)
      r1 = Fabricate(:relationship, leader_id: hank.id,  follower_id: joe.id)
      delete :destroy, id: r1.id
      expect(Relationship.count).to eq(1)
    end


  end


end
