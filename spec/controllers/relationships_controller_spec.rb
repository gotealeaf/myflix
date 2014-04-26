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

  describe "POST create" do
    it "redirects to user page" do
      ana = Fabricate :user
      set_current_user ana
      tom = Fabricate :user     
      relationship = Fabricate :relationship, user: tom, follower: ana   

      post :create, user_id: tom.id

      expect(response).to redirect_to people_path     
    end

    it "creates a reverse relationship between the current user and the selected user" do
      ana = Fabricate :user
      set_current_user ana
      tom = Fabricate :user     

      post :create, user_id: tom.id

      expect(ana.reverse_relationships.first.follower).to eq(ana)
      expect(ana.reverse_relationships.first.user).to eq(tom)     
    end

    it "does not create the relationship if it already exists" do
      ana = Fabricate :user
      set_current_user ana
      tom = Fabricate :user     
      relationship = Fabricate :relationship, user: tom, follower: ana   
      
      post :create, user_id: tom.id
      
      expect(ana.reverse_relationships.count).to eq(1)
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :create, user_id: 1 }
    end
  end
end