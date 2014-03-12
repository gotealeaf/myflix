require 'spec_helper'

describe RelationshipsController do
  describe 'GET index' do
    it_behaves_like "require sign in" do
      let(:action) { get :index }
    end
    it "sets the leader object" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: alice, leader: bob)
      get :index
      expect(assigns(:leaders)).to eq([bob])
    end
  end

  describe 'POST create' do
    it_behaves_like "require sign in" do
      let(:action) { post :create, user_id: 1 }
    end
    it "should redirect to the People page" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      post :create, user_id: bob.id
      expect(response).to redirect_to people_path
    end
    it "should create a relationship between the follow and the leader" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      post :create, user_id: bob.id
      expect(Relationship.count).to eq(1)
    end
    it "should have Alice following Bob" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      post :create, user_id: bob.id
      expect(bob.followers).to eq([alice])
    end
    it "should not create a relationship if it already exists" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: alice, leader: bob)
      post :create, user_id: bob.id
      expect(Relationship.count).to eq(1)
    end
    it "should not allow the current user to follow himself" do
      alice = Fabricate(:user)
      set_current_user(alice)
      post :create, user_id: alice.id
      expect(Relationship.count).to eq(0)
    end
  end

  describe 'DELETE destroy' do
    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, id: 1 }
    end
    it "redirects to the People page" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: alice, leader: bob)
      delete :destroy, id: bob.id
      expect(response).to redirect_to people_path
    end
    it "deletes the relationship" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: alice, leader: bob)
      delete :destroy, id: bob.id
      expect(alice.leaders).to eq([])
    end
    it "does not delete the relationship if current user is not follower" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      charlie = Fabricate(:user)
      Fabricate(:relationship, follower: charlie, leader: bob)
      delete :destroy, id: bob.id
      expect(Relationship.count).to eq(1)
    end
  end
end