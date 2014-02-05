require 'spec_helper'

describe RelationshipsController do
  before do
    request.env["HTTP_REFERER"] = "http://fake.referal/id" unless request.nil? or request.env.nil?
  end

  describe 'GET #index' do
    it_behaves_like 'an unauthenticated user' do
      let(:action) { get :index }
    end

    it 'sets @relationships variable to an array containing the current users relationships' do
      adam = Fabricate(:user)
      set_current_user(adam)
      bryan = Fabricate(:user)
      charles = Fabricate(:user)
      relationship1 = Fabricate(:relationship, user: adam, leader: bryan)
      relationship2 = Fabricate(:relationship, user: adam, leader: charles)
      get :index
      expect(assigns(:relationships)).to match_array([relationship1, relationship2])
    end
  end

  describe 'POST #create' do
    it_behaves_like 'an unauthenticated user' do
      let(:action) { post :create }
    end

    context 'with valid parameters' do
      it 'does not create a relationship if leader and follower are the same user' do
        adam = Fabricate(:user)
        set_current_user(adam)
        post :create, leader_id: adam.id
        expect(adam.relationships).to eq([])
      end

      it 'creates a relationship where the current user is following the given user' do
        adam = Fabricate(:user)
        set_current_user(adam)
        bryan = Fabricate(:user)
        post :create, leader_id: bryan.id
        expect(adam.relationships.first.leader).to eq(bryan)
      end

      it 'redirects user to the previous page' do
        adam = Fabricate(:user)
        set_current_user(adam)
        bryan = Fabricate(:user)
        post :create, leader_id: bryan.id
        expect(response).to redirect_to(request.env['HTTP_REFERER'])
      end

      it 'sets a success message if relationship was created' do
        adam = Fabricate(:user)
        set_current_user(adam)
        bryan = Fabricate(:user)
        post :create, leader_id: bryan.id
        expect(flash[:success]).not_to be_blank
      end

      it 'does not create the relationship if a matching one already exists' do
        adam = Fabricate(:user)
        set_current_user(adam)
        bryan = Fabricate(:user)
        Fabricate(:relationship, user: adam, leader: bryan)
        post :create, leader_id: bryan.id
        expect(flash[:danger]).not_to be_blank
      end
    end

    context 'with invalid parameters' do
      it 'does not create relationship if invalid leader_id is provided' do
        adam = Fabricate(:user)
        set_current_user(adam)
        post :create, leader_id: 10
        expect(adam.relationships.count).to eq(0)
      end

      it 'does not create relationship if no leader_id is provided' do
        adam = Fabricate(:user)
        set_current_user(adam)
        post :create
        expect(adam.relationships.count).to eq(0)
      end

      it 'sets a failure message if relationship was not created' do
        adam = Fabricate(:user)
        set_current_user(adam)
        post :create, leader_id: 10
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'an unauthenticated user' do
      let(:action) { post :destroy, id: 1 }
    end

    it 'deletes the relationship with the given id' do
      adam = Fabricate(:user)
      set_current_user(adam)
      relationship = Fabricate(:relationship, user: adam)
      post :destroy, id: relationship.id
      expect(adam.relationships).to eq([])
    end

    it 'does not delete the relationship unless it is owned by the current user' do
      adam = Fabricate(:user)
      set_current_user(adam)
      relationship = Fabricate(:relationship)
      post :destroy, id: relationship.id
      expect(Relationship.count).to eq(1)
    end

    it 'sets a success message if the relationship is deleted' do
      adam = Fabricate(:user)
      set_current_user(adam)
      relationship = Fabricate(:relationship, user: adam)
      post :destroy, id: relationship.id
      expect(flash[:success]).not_to be_blank
    end
    it 'sets a failure message if the relationship is not deleted' do
      adam = Fabricate(:user)
      set_current_user(adam)
      relationship = Fabricate(:relationship)
      post :destroy, id: relationship.id
      expect(flash[:danger]).not_to be_blank
    end

    it 'redirects to the previous page' do
      adam = Fabricate(:user)
      set_current_user(adam)
      relationship = Fabricate(:relationship, user: adam)
      post :destroy, id: relationship.id
      expect(response).to redirect_to(request.env['HTTP_REFERER'])
    end
  end
end
