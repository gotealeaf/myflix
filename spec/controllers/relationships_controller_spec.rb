require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do 
    it_behaves_like "require_sign_in" do
      let(:action) { get :index, user_id: 3 }
    end

    it "sets @followed_people with the current user's reverse_relationships" do
      ana = Fabricate :user
      set_current_user ana
      tom = Fabricate :user
      
      relationship = Fabricate :relationship, user: tom, follower: ana

      get :index

      expect(assigns :relationships).to match_array([relationship])
    end
  end

  describe "DELETE destroy" do
    it "render to user_relationships if the current user is the follower" do
      ana = Fabricate :user
      set_current_user ana
      tom = Fabricate :user     
      relationship = Fabricate :relationship, user: tom, follower: ana      

      delete :destroy, id: relationship

      expect(response).to redirect_to people_path ana       
    end

    it "deletes the selected relationship" do
      ana = Fabricate :user
      set_current_user ana
      tom = Fabricate :user     
      relationship = Fabricate :relationship, user: tom, follower: ana      

      delete :destroy, id: relationship

      expect(Relationship.count).to eq(0) 
    end

    it "does not destroy the relationship if the user is not logged user" do
      ana = Fabricate :user
      set_current_user ana
      tom = Fabricate :user     
      relationship = Fabricate :relationship, user: ana, follower: tom      

      delete :destroy, id: relationship

      expect(tom.reverse_relationships).to eq([relationship])     
    end

    it_behaves_like "require_sign_in" do
      let(:action) { delete :destroy, id: 1 }
    end
  end

  describe "GET create" do

  end
end